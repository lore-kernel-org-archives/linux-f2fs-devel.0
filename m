From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: refactor bio-related operations
Date: Wed, 04 Dec 2013 17:10:43 +0900
Message-ID: <1386144643.2417.148.camel@kjgkr>
References: <1385792739-31405-1-git-send-email-jaegeuk.kim@samsung.com>
 <1385972847.2417.113.camel@kjgkr> <001101cef0b6$562766e0$027634a0$@samsung.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <001101cef0b6$562766e0$027634a0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, =?UTF-8?Q?=E8=B0=AD=E5=A7=9D?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

> > +	if (btype == META)
> > +		rw |= REQ_META;
> > +
> > +	if (is_read_io(rw)) {
> > +		if (sync)
> > +			rw |= READ_SYNC;
> > +		submit_bio(rw, io->bio);
> > +		trace_f2fs_submit_read_bio(sbi->sb, rw, type, io->bio);
> > +		io->bio = NULL;
> > +		return;
> > +	}
> > +
> > +	if (sync)
> > +		rw |= WRITE_SYNC;
> 
> rw = WRITE_SYNC; ?

No, since it removes the REQ_META.
See above.

> 
> > +	if (type >= META_FLUSH)
> > +		rw |= WRITE_FLUSH_FUA;
> 
> rw = WRITE_FLUSH_FUA; ?
> 
> > +
> > +	/*
> > +	 * META_FLUSH is only from the checkpoint procedure, and we should wait
> > +	 * this metadata bio for FS consistency.
> > +	 */
> > +	if (type == META_FLUSH) {
> > +		DECLARE_COMPLETION_ONSTACK(wait);
> > +		io->bio->bi_private = &wait;
> > +		submit_bio(rw, io->bio);
> > +		wait_for_completion(&wait);
> > +	} else {
> > +		submit_bio(rw, io->bio);
> > +	}
> > +	trace_f2fs_submit_write_bio(sbi->sb, rw, btype, io->bio);
> > +	io->bio = NULL;
> > +}
> 
> [snip]
> 
> Thanks,
> Yu
> 

-- 
Jaegeuk Kim
Samsung
