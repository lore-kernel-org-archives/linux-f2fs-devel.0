From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 3/6] fscrypt: use HKDF-SHA512 to derive the
 per-inode encryption keys
Date: Thu, 13 Jul 2017 11:10:57 -0700
Message-ID: <20170713181057.GA143898@gmail.com>
References: <20170712210035.51534-1-ebiggers3@gmail.com>
	<20170712210035.51534-4-ebiggers3@gmail.com>
	<2034167.Brpu2WxA6s@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ebiggers3@gmail.com>) id 1dViZu-0000yI-AP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Jul 2017 18:11:06 +0000
Received: from mail-pg0-f68.google.com ([74.125.83.68])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dViZt-0006oy-4R
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Jul 2017 18:11:06 +0000
Received: by mail-pg0-f68.google.com with SMTP id y129so7784275pgy.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 13 Jul 2017 11:11:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2034167.Brpu2WxA6s@tauon.chronox.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, herbert@gondor.apana.org.au, Eric Biggers <ebiggers@google.com>, Alex Cope <alexcope@google.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org

Hi Stephan,

On Thu, Jul 13, 2017 at 04:54:55PM +0200, Stephan M=FCller wrote:
> Am Mittwoch, 12. Juli 2017, 23:00:32 CEST schrieb Eric Biggers:
> =

> Hi Herbert,
> =

> This patch adds a second KDF to the kernel -- the first is found in the k=
eys =

> subsystem.
> =

> The next KDF that may come in is in the TLS scope.
> =

> Would it make sense to warm up the KDF patches adding generic KDF support=
 to =

> the kernel crypto API that I supplied some time ago? The advantages would=
 be =

> to have one location of KDF implementations and the benefit of the testmg=
r.
> =


That may be a good idea.  Looking at the old thread, I share Herbert's conc=
ern
(http://www.spinics.net/lists/linux-crypto/msg21231.html) about there likel=
y not
being more than one implementation of each KDF algorithm.  So, perhaps some
simple helper functions would be more appropriate.  However, making the KDF=
s be
covered by self-tests would be very nice.

Also, it seems your patch
(http://www.spinics.net/lists/linux-crypto/msg21137.html) doesn't allow a s=
alt
to be passed in.  In order to fully support HKDF, crypto_rng_reset() (which=
 as I
understand would be the way to invoke the "extract" step) would somehow nee=
d to
accept both the input keying material and salt, both of which are arbitrary
length binary.

Eric

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
