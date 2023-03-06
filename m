Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66158C678D4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Mar 2023 16:15:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZDUr-0002zT-7x;
	Mon, 06 Mar 2023 16:15:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <SRS0=eSXo=66=goodmis.org=rostedt@kernel.org>)
 id 1pZDUj-0002z8-B5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Mar 2023 16:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6a6XSzK64BKVVoRoUiDwkmW4m1s9vunoFJshY+2AUh0=; b=AhIfeweG+rE0Eir2AwDt9aZ/oT
 MEHbb+5BUTmJRBBMqOE+AAUTSpeGkWNgaTI1PyRoNGaFo04zmP2u0tMQFdsKXwqKPYXF2UbmlGwTt
 a/TFcwcnalxaODCNIdxV+ZU953Ko+q8A7eJSTWvuMbyk6qpEqa9c+bofiXLfBHJNehf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6a6XSzK64BKVVoRoUiDwkmW4m1s9vunoFJshY+2AUh0=; b=hUMpYJZsilLCjNHu0YMTnxmtqT
 wrQmP7AW4v6z3acGK/7qufP3zQiTk/4j4wTiIusNxfjoSEqzCyJMlYllcL8yleIjmWTMeZc/KB+2g
 UqN6EjuOd1G3TzyXnMsHUFYnKYwOvRAVUxdFJgzOBFAbiickAGmVx5ml8XnTpy3fwkqs=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZDUg-001AAD-HV for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Mar 2023 16:15:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4BDD3B80FA7;
 Mon,  6 Mar 2023 16:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EACCC433A0;
 Mon,  6 Mar 2023 16:15:14 +0000 (UTC)
Date: Mon, 6 Mar 2023 11:15:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Douglas RAILLARD <douglas.raillard@arm.com>
Message-ID: <20230306111513.2aa49b1a@gandalf.local.home>
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1pZDUg-001AAD-HV
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace
 event
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
Cc: "open list:TRACING" <linux-kernel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Masami Hiramatsu <mhiramat@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon,  6 Mar 2023 12:25:49 +0000
Douglas RAILLARD <douglas.raillard@arm.com> wrote:

> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 31d994e6b4ca..8d053838d6cf 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
>  		__field(ino_t,	ino)
> -		__field(nid_t,	nid[3])

That should not have even compiled. I'll see if I can add some tricks to
make that fail.

Thanks,

-- Steve


> +		__array(nid_t,	nid, 3)
>  		__field(int,	depth)
>  		__field(int,	err)
>  	),


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
