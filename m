From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3] f2fs: report error if quota off error
 during umount
Date: Sat, 28 Jul 2018 20:41:54 -0700
Message-ID: <20180729034154.GA97518@jaegeuk-macbookpro.roam.corp.google.com>
References: <1529989963-24570-1-git-send-email-heyunlei@huawei.com>
 <18d4965a-7358-c057-32ea-9db6395bd56f@huawei.com>
 <d39bdd51-f5e2-29df-b8ca-73e6c68bc85a@huawei.com>
 <20180729020601.GI83620@jaegeuk-macbookpro.roam.corp.google.com>
 <b5596bf0-8772-3947-dc7f-aa2f3e936a26@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fjcao-0007Kl-57
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 03:42:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fjcam-001X5P-Hj
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 29 Jul 2018 03:42:02 +0000
Content-Disposition: inline
In-Reply-To: <b5596bf0-8772-3947-dc7f-aa2f3e936a26@kernel.org>
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
Cc: zhangdianfang@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 07/29, Chao Yu wrote:
> On 2018/7/29 10:06, Jaegeuk Kim wrote:
> > On 07/28, Chao Yu wrote:
> >> Ping,
> > 
> > Please check dev-test.
> 
> I still can't find this patch in last dev-test...

Oh, I recalled what happened on this patch. I didn't merge this, since fault
injection test was failed due to this.
Let me check, once everyting is stabilized.

Thanks,

> 
> Thanks,
> 
> > 
> >>
> >> On 2018/6/26 16:34, Chao Yu wrote:
> >>> On 2018/6/26 13:12, Yunlei He wrote:
> >>>> Now, we depend on fsck to ensure quota file data is ok,
> >>>> so we scan whole partition if checkpoint without umount
> >>>> flag. It's same for quota off error case, which may make
> >>>> quota file data inconsistent.
> >>>>
> >>>> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> >>>
> >>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>>
> >>> Thanks,
> >>>
> >>>
> >>> ------------------------------------------------------------------------------
> >>> Check out the vibrant tech community on one of the world's most
> >>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>>
> >>>
> > 
> > ------------------------------------------------------------------------------
> > Check out the vibrant tech community on one of the world's most
> > engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
