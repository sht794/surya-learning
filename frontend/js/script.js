/* =====================================================
   MOBILE MENU
===================================================== */

const menuToggle = document.getElementById("menuToggle");
const nav = document.getElementById("nav");

menuToggle.addEventListener("click", () => {

    menuToggle.classList.toggle("active");
    nav.classList.toggle("open");

});


/* Close mobile menu when clicking a link */

document.querySelectorAll(".nav-link, .nav-button")
    .forEach(link => {

        link.addEventListener("click", () => {

            menuToggle.classList.remove("active");
            nav.classList.remove("open");

        });

    });


/* =====================================================
   HEADER SCROLL EFFECT
===================================================== */

const header = document.getElementById("header");

window.addEventListener("scroll", () => {

    if (window.scrollY > 30) {
        header.classList.add("scrolled");
    } else {
        header.classList.remove("scrolled");
    }

});


/* =====================================================
   ACTIVE NAVIGATION
===================================================== */

const sections = document.querySelectorAll("section[id]");
const navLinks = document.querySelectorAll(".nav-link");

function updateActiveNavigation() {

    let currentSection = "";

    sections.forEach(section => {

        const sectionTop = section.offsetTop - 150;
        const sectionHeight = section.offsetHeight;

        if (
            window.scrollY >= sectionTop &&
            window.scrollY < sectionTop + sectionHeight
        ) {
            currentSection = section.getAttribute("id");
        }

    });

    navLinks.forEach(link => {

        link.classList.remove("active");

        if (
            link.getAttribute("href") === `#${currentSection}`
        ) {
            link.classList.add("active");
        }

    });

}

window.addEventListener(
    "scroll",
    updateActiveNavigation
);


/* =====================================================
   SCROLL REVEAL ANIMATION
===================================================== */

const animatedElements = document.querySelectorAll(
    ".feature-card, .testimonial, .pricing-card, .about-main-card"
);

const observer = new IntersectionObserver(
    (entries, observer) => {

        entries.forEach(entry => {

            if (entry.isIntersecting) {

                entry.target.classList.add("visible");

                observer.unobserve(entry.target);

            }

        });

    },
    {
        threshold: 0.15
    }
);

animatedElements.forEach(element => {
    observer.observe(element);
});


/* =====================================================
   STAGGER CARD ANIMATIONS
===================================================== */

document.querySelectorAll(".features-grid").forEach(grid => {

    grid.querySelectorAll(".feature-card")
        .forEach((card, index) => {

            card.style.transitionDelay =
                `${index * 100}ms`;

        });

});


document.querySelectorAll(".testimonials-grid").forEach(grid => {

    grid.querySelectorAll(".testimonial")
        .forEach((card, index) => {

            card.style.transitionDelay =
                `${index * 100}ms`;

        });

});


document.querySelectorAll(".pricing-grid").forEach(grid => {

    grid.querySelectorAll(".pricing-card")
        .forEach((card, index) => {

            card.style.transitionDelay =
                `${index * 100}ms`;

        });

});


/* =====================================================
   SMOOTH ANCHOR SCROLL
===================================================== */

document.querySelectorAll('a[href^="#"]')
    .forEach(anchor => {

        anchor.addEventListener("click", function (event) {

            const targetId =
                this.getAttribute("href");

            if (targetId === "#") {
                return;
            }

            const target =
                document.querySelector(targetId);

            if (!target) {
                return;
            }

            event.preventDefault();

            const headerHeight =
                document.querySelector(".header")
                    .offsetHeight;

            const targetPosition =
                target.getBoundingClientRect().top +
                window.scrollY -
                headerHeight;

            window.scrollTo({
                top: targetPosition,
                behavior: "smooth"
            });

        });

    });


/* =====================================================
   INITIALIZATION
===================================================== */

updateActiveNavigation();