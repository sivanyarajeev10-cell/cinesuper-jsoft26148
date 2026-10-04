// 1. Connect to Supabase
const db = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// 2. Page elements
const grid        = document.getElementById("movieGrid");
const statusEl    = document.getElementById("status");
const searchInput = document.getElementById("search");
const genreFilter = document.getElementById("genreFilter");
const modal       = document.getElementById("modal");
const movieDetail = document.getElementById("movieDetail");
const reviewList  = document.getElementById("reviewList");
const reviewForm  = document.getElementById("reviewForm");

let movies = [];
let ratingsMap = {};
let currentMovieId = null;

// Stops users injecting HTML/JS through reviews (safe in text and attributes)
function escapeHtml(text) {
	return String(text ?? "")
		.replace(/&/g, "&amp;")
		.replace(/</g, "&lt;")
		.replace(/>/g, "&gt;")
		.replace(/"/g, "&quot;")
		.replace(/'/g, "&#39;");
}

function showError(error) {
	console.error(error);
	statusEl.textContent = "❌ Error: " + error.message;
}

// 3. SELECT id, name FROM genres ORDER BY name
async function loadGenres() {
	const { data, error } = await db.from("genres").select("id, name").order("name");
	if (error) return showError(error);
	data.forEach((g) => {
		const opt = document.createElement("option");
		opt.value = g.id;
		opt.textContent = g.name;
		genreFilter.appendChild(opt);
	});
}

// 4. SELECT * FROM movie_ratings (the view)
async function loadRatings() {
	const { data, error } = await db.from("movie_ratings").select("id, avg_rating, review_count");
	if (error) return console.error(error);
	ratingsMap = {};
	data.forEach((r) => (ratingsMap[r.id] = r));
}

// 5. SELECT movies JOIN genres, with search and filter
async function loadMovies() {
	statusEl.textContent = "Loading movies...";

	let query = db
		.from("movies")
		.select("id, title, release_year, language, duration_min, description, poster_url, genres(name)")
		.order("release_year", { ascending: false });

	const search = searchInput.value.trim();
	const genreId = genreFilter.value;
	if (search)  query = query.ilike("title", `%${search}%`);
	if (genreId) query = query.eq("genre_id", genreId);

	const { data, error } = await query;
	if (error) return showError(error);

	movies = data;
	statusEl.textContent = data.length ? `${data.length} movie(s) found` : "No movies found 😕";
	grid.innerHTML = data.map(movieCard).join("");
	document.querySelectorAll(".card").forEach((card) =>
		card.addEventListener("click", () => openMovie(Number(card.dataset.id)))
	);
}

function movieCard(m) {
	const r = ratingsMap[m.id];
	const stars = r && r.avg_rating ? `⭐ ${r.avg_rating} (${r.review_count})` : "No ratings yet";
	return `
		<div class="card" data-id="${m.id}">
			<img src="${escapeHtml(m.poster_url)}" alt="${escapeHtml(m.title)}">
			<div class="card-body">
				<h3>${escapeHtml(m.title)}</h3>
				<p>${m.release_year} · ${escapeHtml(m.language)} · ${escapeHtml(m.genres?.name)}</p>
				<p class="stars">${stars}</p>
			</div>
		</div>`;
}

// 6. Movie detail popup
async function openMovie(id) {
	const m = movies.find((x) => x.id === id);
	if (!m) return;
	currentMovieId = id;
	movieDetail.innerHTML = `
		<h2>${escapeHtml(m.title)}</h2>
		<p class="meta">${m.release_year} · ${escapeHtml(m.language)} · ${escapeHtml(m.genres?.name)} · ${m.duration_min} min</p>
		<p>${escapeHtml(m.description)}</p>`;
	modal.classList.remove("hidden");
	await loadReviews(id);
}

// 7. SELECT * FROM reviews WHERE movie_id = ?
async function loadReviews(movieId) {
	reviewList.innerHTML = "<p>Loading reviews...</p>";
	const { data, error } = await db
		.from("reviews")
		.select("reviewer_name, rating, comment, created_at")
		.eq("movie_id", movieId)
		.order("created_at", { ascending: false });

	if (error) {
		reviewList.innerHTML = `<p>Error: ${escapeHtml(error.message)}</p>`;
		return;
	}
	reviewList.innerHTML = data.length
		? data.map((r) => `
				<div class="review">
					<strong>${"⭐".repeat(r.rating)}</strong> — ${escapeHtml(r.reviewer_name)}
					<p>${escapeHtml(r.comment)}</p>
					<small>${new Date(r.created_at).toLocaleString()}</small>
				</div>`).join("")
		: "<p>No reviews yet. Be the first!</p>";
}

// 8. INSERT INTO reviews
reviewForm.addEventListener("submit", async (e) => {
	e.preventDefault();
	const newReview = {
		movie_id: currentMovieId,
		reviewer_name: document.getElementById("reviewerName").value.trim(),
		rating: Number(document.getElementById("reviewRating").value),
		comment: document.getElementById("reviewComment").value.trim(),
	};
	const { error } = await db.from("reviews").insert(newReview);
	if (error) {
		alert("Could not save review: " + error.message);
		return;
	}
	reviewForm.reset();
	await loadReviews(currentMovieId);
	await loadRatings();
	await loadMovies();
});

// 9. Close popup
document.getElementById("closeModal").addEventListener("click", () => modal.classList.add("hidden"));
modal.addEventListener("click", (e) => { if (e.target === modal) modal.classList.add("hidden"); });
document.addEventListener("keydown", (e) => { if (e.key === "Escape") modal.classList.add("hidden"); });

// 10. Search (waits until typing stops) and genre filter
let typingTimer;
searchInput.addEventListener("input", () => {
	clearTimeout(typingTimer);
	typingTimer = setTimeout(loadMovies, 300);
});
genreFilter.addEventListener("change", loadMovies);

// 11. Start
async function init() {
	await loadGenres();
	await loadRatings();
	await loadMovies();
}
init();
