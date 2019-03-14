From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH f2fs] f2fs: f2fs_submit_ipu_bio() can be
 static
Date: Thu, 14 Mar 2019 10:48:29 -0700
Message-ID: <20190314174829.GA65912@jaegeuk-macbookpro.roam.corp.google.com>
References: <201903140706.NPV5nM0E%lkp@intel.com>
 <20190313235358.GA47610@lkp-kbuild04>
 <80739307-8abf-4530-7228-ae737c6eeded@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1h4UTA-0001Lm-TZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Mar 2019 17:48:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4UT6-001a8K-80
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 14 Mar 2019 17:48:40 +0000
Content-Disposition: inline
In-Reply-To: <80739307-8abf-4530-7228-ae737c6eeded@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, kbuild test robot <lkp@intel.com>, kbuild-all@01.org

On 03/14, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Could you merge this into ("f2fs: add bio cache for IPU")?

Done.

> 
> Thanks,
> 
> On 2019-3-14 7:53, kbuild test robot wrote:
> > 
> > Fixes: 60686faa1e20 ("f2fs: add bio cache for IPU")
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> > ---
> >  data.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 6908469..9381f76 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -517,7 +517,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
> >  	return 0;
> >  }
> >  
> > -void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
> > +static void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
> >  							struct page *page)
> >  {
> >  	if (!bio)
> > 
