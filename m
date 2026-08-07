Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAB5C5AC7A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HoEuUD+YSVFJXMt39VM04Pzloh0iSuG++Ivzt5KfgSM=; b=hGx9IIPa+5yawNnqnOlYqK+BET
	CFTlbnDVZuAnmIcOtlNhh8K2Vr4MBGnGj8jJb1ukWqJOSarE4CN48wjwmyK0odvq4YSY62O27xVhB
	zI7F01DKbkRTzxIm7Jn0/mIoQtbLitLO1A/O16TbzOHddc3omd4ey+zIuLa/nC3gOYU0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsQcn-0000Sk-Ka;
	Fri, 07 Aug 2026 19:53:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rostedt@goodmis.org>) id 1wsQcm-0000ST-Oi
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 19:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BUZfp25BZPnyvqm+B7MkcTGB6K68ZcunUSZQi/SHiNI=; b=XWEw/7/tCgehzFTVYEcO7Mt7bV
 mHNTgbnwz/1h+bTuGNj5wEKVfxzRAsxwQ1GeWHvnFioot0EiKx6sJP++pBf6hqdkC1mvrJPOJ1ca2
 +NaIQD119nCrbkwJ96ALz1/+JccvLqQtIcXvPewV30eTgqQI4OQj1uQuwtu65c6OHTTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BUZfp25BZPnyvqm+B7MkcTGB6K68ZcunUSZQi/SHiNI=; b=VrxqLwDZnP3c+rTTsTkczEHiIH
 qHbvH6GXs96B1Hwtes/EoOdJA2ckFJRBmQJcgvogAsjBuCKi2yPMDyTIL5UUoNDdJ+KUG4hsaxHub
 GONfKRuXENW0tWgWdvORi8kZDzj9BgyKxk/OPT2z6AImUNT+QzWqURIVeX3UCZeUm+5w=;
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]
 helo=relay.hostedemail.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsQcl-0003Kg-4g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 19:53:00 +0000
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
 by unirelay05.hostedemail.com (Postfix) with ESMTP id 806834013F;
 Fri,  7 Aug 2026 19:33:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by
 omf14.hostedemail.com (Postfix) with ESMTPA id CC7CE2F; 
 Fri,  7 Aug 2026 19:33:16 +0000 (UTC)
Date: Fri, 7 Aug 2026 15:33:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bart Van Assche <bvanassche@acm.org>
Message-ID: <20260807153320.3d17e0be@gandalf.local.home>
In-Reply-To: <31b06883a88b8169f2d9be8ac7303bfe14cf1530.1786122586.git.bvanassche@acm.org>
References: <31b06883a88b8169f2d9be8ac7303bfe14cf1530.1786122586.git.bvanassche@acm.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CC7CE2F
X-Stat-Signature: w16xd5q5dt7ffs7ph94pri98mwsayxcq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/zORgLZI8wtrgXflamttpuDWR0N2hYUI=
X-HE-Tag: 1786131196-363697
X-HE-Meta: U2FsdGVkX182/yvAdRrfwPKHp8DyRoRsNYU+hK8RWjq8vLylfB5F2zPrFUU4SLtPLWLCMPce0jgVYienbvw/bLOmYYgfkwg0Wd0bFCldQfcbiuidBh5+MP4tXuDTwtgx2sy5zIwFqPVtpf+8e7cJo8WjMvQNp1Gv7EfgyaFnavLBJIwv1aLMK0hqOyXGOlbsU49aLLmgTkRzlcCuiPSE/sGxmJPjW5waEbGq+TbeGH8IOyogeifU5pyMwmoSYtOekJyVn+j5siCdEO2W8734v3XpsWNeV+kVSHuGbCV1e+tT5K2EA7yiGVIDtURE2dNuLn3doD3wOB/s0pW8aSAxvxRGlnAMiHLC
X-Headers-End: 1wsQcl-0003Kg-4g
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix multiple sparse warnings
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri,  7 Aug 2026 10:10:56 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 270c1a2c24c4..7f5ce92afe0f 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -1493,7 +1493,8 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
>  		show_dev_ino(__entry),
>  		(unsigned long)__entry->index,
>  		__print_flags(__entry->flags, "|", FAULT_FLAG_TRACE),
> -		__print_flags(__entry->ret, "|", VM_FAULT_RESULT_TRACE))
> +		__print_flags((__force unsigned long)__entry->ret, "|",
> +			      VM_FAULT_RESULT_TRACE))
>  );
>  
>  DEFINE_EVENT(f2fs_mmap, f2fs_filemap_fault,

The above shows up in the tracefs file for this event. Can you make sure
libtraceevent still parses it fine? (Check with trace-cmd to see if it
fails to parse the event).

-- Steve


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
