From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH V2 3/7] fscrypt: remove filesystem specific
 build config option
Date: Tue, 4 Dec 2018 16:05:28 -0800
Message-ID: <20181205000528.GH70682@gmail.com>
References: <20181204095650.12562-1-chandan@linux.vnet.ibm.com>
 <20181204095650.12562-4-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gUKh7-0002yw-VG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Dec 2018 00:05:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gUKh6-001Z46-LC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Dec 2018 00:05:37 +0000
Content-Disposition: inline
In-Reply-To: <20181204095650.12562-4-chandan@linux.vnet.ibm.com>
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

On Tue, Dec 04, 2018 at 03:26:46PM +0530, Chandan Rajendra wrote:
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 952ab97af325..6ba193c23f37 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -2,9 +2,8 @@
>  /*
>   * fscrypt.h: declarations for per-file encryption
>   *
> - * Filesystems that implement per-file encryption include this header
> - * file with the __FS_HAS_ENCRYPTION set according to whether that filesystem
> - * is being built with encryption support or not.
> + * Filesystems that implement per-file encryption must include this header
> + * file.
>   *
>   * Copyright (C) 2015, Google, Inc.
>   *

There's still a definition of __FS_HAS_ENCRYPTION in
fs/crypto/fscrypt_private.h.  This patch removes everything that checks
__FS_HAS_ENCRYPTION, so that should be removed too.

Thanks,

- Eric
