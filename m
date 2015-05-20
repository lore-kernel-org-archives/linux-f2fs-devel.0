From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs crypto: check encryption for tmpfile
Date: Tue, 19 May 2015 23:00:24 -0700
Message-ID: <20150520055859.GA59011@jaegeuk-mac02.mot-mobility.com>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
 <1432082606-55975-3-git-send-email-jaegeuk@kernel.org>
 <20150520044604.GD2871@thunk.org>
 <20150520050125.GB56982@jaegeuk-mac02.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150520050125.GB56982@jaegeuk-mac02.hsd1.ca.comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, May 19, 2015 at 10:01:25PM -0700, Jaegeuk Kim wrote:
> On Wed, May 20, 2015 at 12:46:04AM -0400, Theodore Ts'o wrote:
> > On Tue, May 19, 2015 at 05:43:25PM -0700, Jaegeuk Kim wrote:
> > > This patch adds to check encryption for tmpfile in early stage.
> > 
> > Don't you also need a call to ext4_inherit_context(dir, inode) here?
> > (I need to fix this for ext4 as well).
> 
> Actually this should be:
> 
> 	err = f2fs_get_encryption_info(inode);   <- for inode.
> 	if (err)
> 		goto out;

Sorry Ted,
Please ignore the above; dir was correct.

> 
> In f2fs, f2fs_do_tmpfile calls f2fs_inherit_context already. :)
> 
> > 
> > 					- Ted
> 
> ------------------------------------------------------------------------------
> One dashboard for servers and applications across Physical-Virtual-Cloud 
> Widest out-of-the-box monitoring support with 50+ applications
> Performance metrics, stats and reports that give you Actionable Insights
> Deep dive visibility with transaction tracing using APM Insight.
> http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
