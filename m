From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: introduce a periodic checkpoint flow
Date: Tue, 6 Oct 2015 16:25:44 -0700
Message-ID: <20151006232544.GB18417@jaegeuk-mac02.mot.com>
References: <1444085040-12843-1-git-send-email-jaegeuk@kernel.org>
 <1444085040-12843-3-git-send-email-jaegeuk@kernel.org>
 <COL402-EAS36963917057FDF0512DE24BAB370@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <COL402-EAS36963917057FDF0512DE24BAB370@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchaochina@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Oct 06, 2015 at 10:54:47PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, October 06, 2015 6:44 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 3/3] f2fs: introduce a periodic checkpoint flow
> > 
> > This patch introduces a periodic checkpoint feature.
> > Note that, this is not enforcing to conduct checkpoints very strictly in terms
> > of trigger timing, instead just hope to help user experiences.
> > The default value is 60 seconds.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Looks good to me except one minor thing that it's better to add a cp_expires
> initialization.

Added. Thanks. :)

> 
> Please append all patches of patch set with:
> Reviewed-by: Chao Yu <chao2.yu@samsung.com>
> 
> Thanks,
