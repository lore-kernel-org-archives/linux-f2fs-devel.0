From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH V2 3/7] fscrypt: remove filesystem specific
 build config option
Date: Mon, 10 Dec 2018 10:04:22 -0800
Message-ID: <20181210180422.GC92174@gmail.com>
References: <20181204095650.12562-1-chandan@linux.vnet.ibm.com>
 <20181204095650.12562-4-chandan@linux.vnet.ibm.com>
 <20181204234320.GC70682@gmail.com>
 <2062340.ny9MuQaG0V@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gWPuz-0005Bb-9i
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 18:04:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gWPux-009uOC-Ix
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Dec 2018 18:04:33 +0000
Content-Disposition: inline
In-Reply-To: <2062340.ny9MuQaG0V@localhost.localdomain>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jhogan@kernel.org, heiko.carstens@de.ibm.com, linux-mtd@lists.infradead.org, deanbo422@gmail.com, linux-s390@vger.kernel.org, corbet@lwn.net, richard@nod.at, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, green.hu@gmail.com, jaegeuk@kernel.org, tytso@mit.edu, dedekind1@gmail.com, adrian.hunter@intel.com, ralf@linux-mips.org, linux-f2fs-devel@lists.sourceforge.net, paul.burton@mips.com, schwidefsky@de.ibm.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk

On Sat, Dec 08, 2018 at 12:37:20PM +0530, Chandan Rajendra wrote:
> On Wednesday, December 5, 2018 5:13:21 AM IST Eric Biggers wrote:
> > Hi Chandan,
> > 
> > On Tue, Dec 04, 2018 at 03:26:46PM +0530, Chandan Rajendra wrote:
> > > In order to have a common code base for fscrypt "post read" processing
> > > for all filesystems which support encryption, this commit removes
> > > filesystem specific build config option (e.g. CONFIG_EXT4_FS_ENCRYPTION)
> > > and replaces it with a build option (i.e. CONFIG_FS_ENCRYPTION) whose
> > > value affects all the filesystems making use of fscrypt.
> > > 
> > > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > [...]
> > > -config F2FS_FS_ENCRYPTION
> > > -	bool "F2FS Encryption"
> > > -	depends on F2FS_FS
> > > -	depends on F2FS_FS_XATTR
> > > -	select FS_ENCRYPTION
> > > -	help
> > > -	  Enable encryption of f2fs files and directories.  This
> > > -	  feature is similar to ecryptfs, but it is more memory
> > > -	  efficient since it avoids caching the encrypted and
> > > -	  decrypted pages in the page cache.
> > > -
> > [...]
> > > -config UBIFS_FS_ENCRYPTION
> > > -	bool "UBIFS Encryption"
> > > -	depends on UBIFS_FS && UBIFS_FS_XATTR && BLOCK
> > > -	select FS_ENCRYPTION
> > > -	default n
> > > -	help
> > > -	  Enable encryption of UBIFS files and directories. This
> > > -	  feature is similar to ecryptfs, but it is more memory
> > > -	  efficient since it avoids caching the encrypted and
> > > -	  decrypted pages in the page cache.
> > 
> > Will it cause problems that now f2fs encryption can be "enabled" without
> > F2FS_FS_XATTR, and ubifs encryption without UBIFS_FS_XATTR && BLOCK?
> > 
> > Otherwise I think this patch looks fine.  I'm a bit concerned about the bloat
> > from making FS_ENCRYPTION non-modular, but given that it will make sharing I/O
> > code much easier, it's probably worthwhile.
> > 
> > It would help to strip down the dependencies of FS_ENCRYPTION to just the stuff
> > needed for just AES-256-XTS and AES-256-CTS.  I already sent out a patch a
> > couple months ago (https://patchwork.kernel.org/patch/10589319/) to remove
> > CONFIG_CTR which isn't used at all; I'll remind Ted to apply that.  But we could
> > also drop CONFIG_SHA256, which is only needed for AES-128-CBC contents
> > encryption.  If we do that, it should be a separate patch, though.
> 
> Hi Eric,
> 
> fscrypt_valid_enc_modes() allows FS_ENCRYPTION_MODE_AES_128_CBC to be used for
> encryption of file's contents. This is consistent with what you had mentioned
> above.
> 
> static inline bool fscrypt_valid_enc_modes(u32 contents_mode,
>                                            u32 filenames_mode)
> {
>         if (contents_mode == FS_ENCRYPTION_MODE_AES_128_CBC &&
>             filenames_mode == FS_ENCRYPTION_MODE_AES_128_CTS)
>                 return true;
> 
>         if (contents_mode == FS_ENCRYPTION_MODE_AES_256_XTS &&
>             filenames_mode == FS_ENCRYPTION_MODE_AES_256_CTS)
>                 return true;
> 
>         return false;
> }
> 
> Hence FS_ENCRYPTION does need to have AES-128-CBC and by extension SHA256 code
> compiled in right? 
> 

No those algorithms don't have to be compiled in if userspace doesn't use the
(FS_ENCRYPTION_MODE_AES_128_CBC, FS_ENCRYPTION_MODE_AES_128_CTS) pair, because
the algorithms are allocated dynamically on-demand through the crypto API.

- Eric
