From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 0/5] f2fs: switch to new fscrypt helper
 functions
Date: Thu, 30 Nov 2017 23:12:42 -0800
Message-ID: <20171201071242.GA86192@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171129203532.87729-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eKfVB-0001Oq-P9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 07:12:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eKfVB-0003Qz-0y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Dec 2017 07:12:49 +0000
Content-Disposition: inline
In-Reply-To: <20171129203532.87729-1-ebiggers3@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-fscrypt@vger.kernel.org, Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net

Thanks, merged.

On 11/29, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This series switches f2fs to use the fscrypt helper functions for
> open/link/rename/lookup/setattr introduced in v4.15.
> 
> These patches were originally sent in "[PATCH 00/25] fscrypt: add some
> higher-level helper functions".  I've rebased them onto v4.15-rc1.
> 
> Eric Biggers (5):
>   f2fs: switch to fscrypt_file_open()
>   f2fs: switch to fscrypt_prepare_link()
>   f2fs: switch to fscrypt_prepare_rename()
>   f2fs: switch to fscrypt_prepare_lookup()
>   f2fs: switch to fscrypt_prepare_setattr()
> 
>  fs/f2fs/file.c  | 30 +++++++-----------------------
>  fs/f2fs/namei.c | 54 +++++++++++++-----------------------------------------
>  2 files changed, 20 insertions(+), 64 deletions(-)
> 
> -- 
> 2.15.0.531.g2ccb3012c9-goog

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
