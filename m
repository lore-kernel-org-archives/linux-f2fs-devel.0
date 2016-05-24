From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Tue, 24 May 2016 01:53:43 -0700
Message-ID: <20160524085343.GC8121@infradead.org>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
 <20160523211357.GA17297@jaegeuk.gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160523211357.GA17297@jaegeuk.gateway>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, May 23, 2016 at 02:13:57PM -0700, Jaegeuk Kim wrote:
> As Christoph mentioned, how about checking the feature only like this?
> 
> 1. if the feature is ON,
>  - go 64 bits   , when compiled w/  F2FS_MIN_16TB_VOLUME_SUPPORT
>  - fail to mount, when compiled w/o F2FS_MIN_16TB_VOLUME_SUPPORT
> 
> 2. if the feature is OFF,
>  - fail to mount, when compiled w/  F2FS_MIN_16TB_VOLUME_SUPPORT
>  - go 32 bits   , when compiled w/o F2FS_MIN_16TB_VOLUME_SUPPORT
> 
> Thoughts?

That goes on to the next question: why do we even need a config option
for 16TB+ volume support?
