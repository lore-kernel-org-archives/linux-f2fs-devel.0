From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 06/10] fs crypto: add Makefile and Kconfig
Date: Mon, 29 Feb 2016 18:04:47 -0800
Message-ID: <20160301020447.GB60850@jaegeuk.hsd1.ca.comcast.net>
References: <1456428368-41527-1-git-send-email-jaegeuk@kernel.org>
	<1456428368-41527-7-git-send-email-jaegeuk@kernel.org>
	<56D3D99B.9090907@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aaZgG-0001et-Jj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 02:04:56 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aaZgF-0008UL-FE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 02:04:56 +0000
Content-Disposition: inline
In-Reply-To: <56D3D99B.9090907@infradead.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-f2fs-devel@lists.sourceforge.net

On Sun, Feb 28, 2016 at 09:39:39PM -0800, Randy Dunlap wrote:
> On 02/25/16 11:26, Jaegeuk Kim wrote:
> > This patch adds a facility to enable per-file encryption.
> > 
> > Arnd fixes a missing CONFIG_BLOCK check in the original patch.
> > "The newly added generic crypto abstraction for file systems operates
> > on 'struct bio' objects, which do not exist when CONFIG_BLOCK is
> > disabled:
> > 
> > fs/crypto/crypto.c: In function 'fscrypt_zeroout_range':
> > fs/crypto/crypto.c:308:9: error: implicit declaration of function 'bio_alloc' [-Werror=implicit-function-declaration]
> > 
> > This adds a Kconfig dependency that prevents FS_ENCRYPTION from being
> > enabled without BLOCK."
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/Kconfig         |  2 ++
> >  fs/Makefile        |  1 +
> >  fs/crypto/Kconfig  | 17 +++++++++++++++++
> >  fs/crypto/Makefile |  2 ++
> >  4 files changed, 22 insertions(+)
> >  create mode 100644 fs/crypto/Kconfig
> >  create mode 100644 fs/crypto/Makefile
> > 
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index 9adee0d..9d75767 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -84,6 +84,8 @@ config MANDATORY_FILE_LOCKING
> >  
> >  	  To the best of my knowledge this is dead code that no one cares about.
> >  
> > +source "fs/crypto/Kconfig"
> > +
> >  source "fs/notify/Kconfig"
> >  
> >  source "fs/quota/Kconfig"
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 79f5225..47571e2 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -30,6 +30,7 @@ obj-$(CONFIG_EVENTFD)		+= eventfd.o
> >  obj-$(CONFIG_USERFAULTFD)	+= userfaultfd.o
> >  obj-$(CONFIG_AIO)               += aio.o
> >  obj-$(CONFIG_FS_DAX)		+= dax.o
> > +obj-y				+= crypto/
> >  obj-$(CONFIG_FILE_LOCKING)      += locks.o
> >  obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
> >  obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
> > diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> > new file mode 100644
> > index 0000000..9bea124e
> > --- /dev/null
> > +++ b/fs/crypto/Kconfig
> > @@ -0,0 +1,17 @@
> > +config FS_ENCRYPTION
> > +	bool "FS Encryption (Per-file encryption)"
> > +	depends on BLOCK
> 
> 	depends on CRYPTO

This complains recursive dependency limitations, and I checked out that below
ENCRYPTED_KEYS in security/keys/Kconfig selects CRYPTO.

Thanks,

> since all of the CRYPTO_xxx below also depend on CRYPTO.
> 
> > +	select CRYPTO_AES
> > +	select CRYPTO_CBC
> > +	select CRYPTO_ECB
> > +	select CRYPTO_XTS
> > +	select CRYPTO_CTS
> > +	select CRYPTO_CTR
> > +	select CRYPTO_SHA256
> > +	select KEYS
> > +	select ENCRYPTED_KEYS
> > +	help
> > +	  Enable encryption of files and directories.  This
> > +	  feature is similar to ecryptfs, but it is more memory
> > +	  efficient since it avoids caching the encrypted and
> > +	  decrypted pages in the page cache.
> > diff --git a/fs/crypto/Makefile b/fs/crypto/Makefile
> > new file mode 100644
> > index 0000000..f9f68cd
> > --- /dev/null
> > +++ b/fs/crypto/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-y += fname.o
> > +obj-$(CONFIG_FS_ENCRYPTION)	+= crypto.o policy.o keyinfo.o
> > 
> 
> 
> -- 
> ~Randy

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
