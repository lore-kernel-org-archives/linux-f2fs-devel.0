From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] libf2fs: Track AOSP libsparse API change.
Date: Fri, 4 May 2018 12:16:23 -0700
Message-ID: <20180504191623.GG27993@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180426074009.36270-1-tbao@google.com>
 <8c5f5989-4c15-2afb-5f68-0a675659ac88@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fEgBz-0003GL-Dp
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 19:16:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fEgBx-004oHW-ML
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 May 2018 19:16:31 +0000
Content-Disposition: inline
In-Reply-To: <8c5f5989-4c15-2afb-5f68-0a675659ac88@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@google.com, linux-f2fs-devel@lists.sourceforge.net

On 05/04, Chao Yu wrote:
> On 2018/4/26 15:40, Tao Bao via Linux-f2fs-devel wrote:
> > The libsparse in AOSP is updating the type for 'len', from 'int' to
> > 'size_t', in the callback parameter of sparse_file_foreach_chunk(). The
> > value represents a chunk size, which could be legitimately larger than
> > INT_MAX. This patch tracks the libsparse API change.
> > 
> > The change is guarded with SPARSE_CALLBACK_USES_SIZE_T that's exposed as
> > part of the libsparse change. This allows f2fs-tools to keep working
> > against older libsparse versions.
> > 
> > Signed-off-by: Tao Bao <tbao@google.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Merged already.

> 
> Thanks,
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
