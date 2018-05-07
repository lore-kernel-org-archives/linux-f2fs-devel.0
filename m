From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] sload.f2fs: fix the missing of bit mask for
 file type
Date: Mon, 7 May 2018 13:06:50 -0700
Message-ID: <20180507200650.GA83867@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180503112506.229441-1-zhengjunling@huawei.com>
 <acce8587-c6e4-7568-8dbe-40dd275c1674@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fFmPT-0000cV-60
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 20:06:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fFmPR-00AkQH-Eb
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 May 2018 20:06:59 +0000
Content-Disposition: inline
In-Reply-To: <acce8587-c6e4-7568-8dbe-40dd275c1674@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Junling Zheng <zhengjunling@huawei.com>
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 05/07, Junling Zheng wrote:
> Hi, Jaegeuk
> 
> Could you please merge this fix into external/f2fs-tools repo for AOSP?
> Since we found this bug while using sload feature in Android P :)

Sure. Will prepare soon.
Thanks,

> 
> Thanks,
> Junling
> 
> On 2018/5/3 19:25, Junling Zheng wrote:
> > Fix the missing of bit mask for the file type bit fields.
> > 
> > Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> > Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> > ---
> >  fsck/sload.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fsck/sload.c b/fsck/sload.c
> > index 2842f2c..1b7a2d1 100644
> > --- a/fsck/sload.c
> > +++ b/fsck/sload.c
> > @@ -157,7 +157,7 @@ static void set_inode_metadata(struct dentry *de)
> >  
> >  	de->size = stat.st_size;
> >  	de->mode = stat.st_mode &
> > -			(S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
> > +			(S_IFMT|S_ISUID|S_ISGID|S_ISVTX|S_IRWXU|S_IRWXG|S_IRWXO);
> >  	if (c.fixed_time == -1 && c.from_dir)
> >  		de->mtime = stat.st_mtime;
> >  	else
> > 
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
