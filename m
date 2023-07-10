Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A69EB64D9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jul 2023 22:44:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qIzc8-0002jA-J5;
	Mon, 10 Jul 2023 22:44:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <SRS0=G8aH=C4=goodmis.org=rostedt@kernel.org>)
 id 1qIzc0-0002iz-Po for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jul 2023 22:44:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WzaIkWWy/2SD+XbdFhmFwNNX2yoQNQ0oNUNqVUZjy5o=; b=QSBEkqjLHU9DGpw+u1NM1j9uun
 Y7X/B0ZL5fuQoY6kTKLXixVyjznSkmggaYWGVIkAeR+WRpa0rdfZp+zA4SVorLDVzPXtka2/LC+Ho
 1SRzDeAHnAR0OmlRbO25r2JO6WiVXZJR90F0q26OpiJvmr/cNAslV94WSW0nL1+EdTVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WzaIkWWy/2SD+XbdFhmFwNNX2yoQNQ0oNUNqVUZjy5o=; b=YQtqCIgO8CxLrsJgWrf9yA/zRy
 8DbH6OjpDCNDP2Jx7nP4NyZmcbJZwx+NKGcL9IGtSyVyhn5MaWa7IAwimfoDv9imDNCuX8OVyFE7Q
 ecBKy5dMT+bKMxutPdz9Mg1y31OUInvhg6Mo8gshp/iOtEDrnCp8eNCakoRnXe8idjik=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qIzbv-003jPg-FS for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jul 2023 22:44:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9274B611FB;
 Mon, 10 Jul 2023 22:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330DEC433C7;
 Mon, 10 Jul 2023 22:43:56 +0000 (UTC)
Date: Mon, 10 Jul 2023 18:43:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <20230710184353.09640aee@gandalf.local.home>
In-Reply-To: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
References: <20230628150243.17771-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Headers-End: 1qIzbv-003jPg-FS
Subject: Re: [f2fs-dev] [PATCH v1 1/1] f2fs: Use return value of strreplace()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Masami Hiramatsu <mhiramat@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, 28 Jun 2023 18:02:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since strreplace() returns the pointer to the string itself,
> we may use it directly in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/trace/events/f2fs.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> index 793f82cc1515..f5994515290c 100644
> --- a/include/trace/events/f2fs.h
> +++ b/include/trace/events/f2fs.h
> @@ -2234,13 +2234,11 @@ DECLARE_EVENT_CLASS(f2fs__rw_start,
>  		 * because this screws up the tooling that parses
>  		 * the traces.
>  		 */
> -		__assign_str(pathbuf, pathname);
> -		(void)strreplace(__get_str(pathbuf), ' ', '_');
> +		__assign_str(pathbuf, strreplace(pathname, ' ', '_'));

But this modifies the pathname that is passed into the trace event, which
is something that a trace point should never do! In fact, the char
*pathname, really should be a const char * (for which this would fail to
build).

Note, I went to look for these events and I can not find where they are
used. Should these events just be deleted?

-- Steve


>  		__entry->offset = offset;
>  		__entry->bytes = bytes;
>  		__entry->i_size = i_size_read(inode);
> -		__assign_str(cmdline, command);
> -		(void)strreplace(__get_str(cmdline), ' ', '_');
> +		__assign_str(cmdline, strreplace(command, ' ', '_'));
>  		__entry->pid = pid;
>  		__entry->ino = inode->i_ino;
>  	),



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
