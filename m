From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3] f2fs: in-memory inode checksum when
 checking consistency
Date: Tue, 27 Feb 2018 21:59:10 -0800
Message-ID: <20180228055910.GA88091@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180226192843.26680-1-guoweichao@huawei.com>
 <b0fb67ac-a620-68df-0472-26f08433e344@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1equlq-0018wg-FM
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 05:59:18 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1equlo-005ohY-Rk
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 05:59:18 +0000
Content-Disposition: inline
In-Reply-To: <b0fb67ac-a620-68df-0472-26f08433e344@huawei.com>
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
Cc: heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/27, Chao Yu wrote:
> On 2018/2/27 3:28, Weichao Guo wrote:
> > Enable in-memory inode checksum to protect metadata blocks
> > from in-memory scribbles only when checking consistency with
> > no performance requirements.
> > 
> > Signed-off-by: Weichao Guo <guoweichao@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

This gives a panic easily by fsstress. Could you please check it again?

Thanks,

> 
> Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
