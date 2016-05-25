From: Viacheslav Dubeyko <slava@dubeyko.com>
Subject: Re: [PATCH] f2fs: introduce on-disk layout version checking
 functionality
Date: Tue, 24 May 2016 17:34:15 -0700
Message-ID: <1464136455.2680.7.camel@slavad-ubuntu-14.04>
References: <1463679966.3573.4.camel@slavad-ubuntu-14.04>
	 <20160523211357.GA17297@jaegeuk.gateway>
	 <20160524085343.GC8121@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524085343.GC8121@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Vyacheslav.Dubeyko@hgst.com, Cyril.Guyot@hgst.com, Adam.Manzanares@hgst.com, Damien.LeMoal@hgst.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, 2016-05-24 at 01:53 -0700, Christoph Hellwig wrote:

[snipped]
> 
> That goes on to the next question: why do we even need a config option
> for 16TB+ volume support?
> 

I believe that it makes sense to have config option during
implementation phase. I mean that it needs to protect this experimental
"feature" from being using till finally stabilized functionality. Then
the config option could be deleted if we haven't necessity in this
option.

Thanks,
Vyacheslav Dubeyko.
