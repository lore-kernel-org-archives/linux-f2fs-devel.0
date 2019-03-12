From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v11] f2fs: guarantee journalled quota data by checkpoint
Date: Tue, 12 Mar 2019 11:28:55 -0700
Message-ID: <20190312182855.GA45421@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180920120500.21026-1-chao@kernel.org>
 <7a2b9277-acbf-eda4-d043-74463d7b61c7@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7a2b9277-acbf-eda4-d043-74463d7b61c7@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Weichao Guo <guoweichao@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 03/06, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2018/9/20 20:05, Chao Yu wrote:
> > @@ -3456,3 +3477,16 @@
> > 
> >  extern void f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned int rate,
> > 
> > #endif
> > #endif
> > +
> > +static inline bool is_journalled_quota(struct f2fs_sb_info *sbi)
> > +{
> > +#ifdef CONFIG_QUOTA
> > + if (f2fs_sb_has_quota_ino(sbi->sb))
> > + return true;
> > + if (F2FS_OPTION(sbi).s_qf_names[USRQUOTA] ||
> > + F2FS_OPTION(sbi).s_qf_names[GRPQUOTA] ||
> > + F2FS_OPTION(sbi).s_qf_names[PRJQUOTA])
> > + return true;
> > +#endif
> > + return false;
> > +}
> 
> I checked dev branch, and found one patch we didn't send to mailing list,
> could you please send it out?
> 
> f2fs: fix wrong #endif
> 
> I think my quota patch caused this 'wrong #endif' issue, could you add
> single line comment to notice which #if the last #endif is corresponding
> to? so that we can avoid same mistake as quota patch made.

Ah, I forgot to post the patch. It's quite late but obvious, and thus let me
keep the patch as is in order to avoid messing up the commit history.

Thanks,
