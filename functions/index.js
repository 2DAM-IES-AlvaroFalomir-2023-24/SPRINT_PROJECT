const functions = require('firebase-functions');
const nodemailer = require('nodemailer');

const mailTransport = nodemailer.createTransport({ // Configuración del transporte de correo electrónico
    service: 'gmail',
    auth: {
        user: 'damproyectoflutter@gmail.com',
        pass: 'Curso2324',
    },
});

exports.sendUserDeletionEmail = functions.https.onCall((data, context) => { // Función para enviar el correo electrónico
    const email = data.email; // El correo electrónico del usuario

    const mailOptions = { // Configuración del correo electrónico
        from: 'Sprint Project <damproyectoflutter@gmail.com>',
        to: email,
        subject: 'Confirmación de Baja de Usuario en SPRINT_PROJECT',
        text: 'Hola, hemos recibido una solicitud para dar de baja tu cuenta. Si no deseas continuar con este proceso, por favor ignora este mensaje.'
    };

    return mailTransport.sendMail(mailOptions).then(() => {
        return { success: true };
    }).catch(error => {
        console.error('Hubo un problema al enviar el correo electrónico', error);
        return { success: false };
    });
});
