Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D1FC001DB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Aug 2023 14:39:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qVYjA-0002Fg-6R;
	Mon, 14 Aug 2023 14:39:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kajetan.puchalski@arm.com>) id 1qVYj7-0002FZ-5e
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 14:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yN4IRHtgPzQhWVs7VwhIu96MliPdEXFxMpapDAGVEgU=; b=CKqcYhjtrrkn3q3bV07GMfW1m+
 FyZ6WfD8aGaqXt1diPgqaqexsMP+aAsNfCer9MDRKA39c7aoX5g6XhzEIQFb57GFJl202KCWGy31B
 JPRSx6LP//qZSUyaZ7xDcI/nIBm+lNMyyzHnVKqtXcwdV9IhHOxdrnznCS3gMHZTrkxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yN4IRHtgPzQhWVs7VwhIu96MliPdEXFxMpapDAGVEgU=; b=FWtQpXYuWqdWqlLSWsEpzxEY43
 expXWPMRcDhDlJgb+W8z4gKoQE+DP40zJZInK2vDQJmx+3e0UMT/CB0ykoOA5KOBzGuNuIWsVv8GB
 q5LCLSZV4OK99uM1HYUGb/Xk77A4b0+1B+UxfPUn4Ef9K9cT9QTFgnnDLfBiAs75DqE8=;
Received: from foss.arm.com ([217.140.110.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1qVYj5-0003DX-Uk for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Aug 2023 14:39:25 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0A031063;
 Mon, 14 Aug 2023 07:40:00 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.65.63])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3DAF3F64C;
 Mon, 14 Aug 2023 07:39:16 -0700 (PDT)
Date: Mon, 14 Aug 2023 15:39:02 +0100
From: Kajetan Puchalski <kajetan.puchalski@arm.com>
To: Douglas RAILLARD <douglas.raillard@arm.com>
Message-ID: <ZNo8hoR2V3Zo14+l@e126311.manchester.arm.com>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
 <ZNotAI1T+hKfzJWV@e126311.manchester.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZNotAI1T+hKfzJWV@e126311.manchester.arm.com>
X-Headers-End: 1qVYj5-0003DX-Uk
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
 Steven Rostedt <rostedt@goodmis.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 jstultz@google.com, Masami Hiramatsu <mhiramat@kernel.org>, qyousef@google.com,
 Jaegeuk Kim <jaegeuk@kernel.org>, lukasz.luba@arm.com,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 14, 2023 at 02:32:53PM +0100, Kajetan Puchalski wrote:
> On Mon, Mar 06, 2023 at 12:25:49PM +0000, Douglas RAILLARD wrote:
> > From: Douglas Raillard <douglas.raillard@arm.com>
> > 
> > Fix the nid_t field so that its size is correctly reported in the text
> > format embedded in trace.dat files. As it stands, it is reported as
> > being of size 4:
> > 
> >         field:nid_t nid[3];     offset:24;      size:4; signed:0;
> > 
> > Instead of 12:
> > 
> >         field:nid_t nid[3];     offset:24;      size:12;        signed:0;
> > 
> > This also fixes the reported offset of subsequent fields so that they
> > match with the actual struct layout.
> > 
> > 
> > Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> > ---
> >  include/trace/events/f2fs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index 31d994e6b4ca..8d053838d6cf 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -512,7 +512,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
> >  	TP_STRUCT__entry(
> >  		__field(dev_t,	dev)
> >  		__field(ino_t,	ino)
> > -		__field(nid_t,	nid[3])
> > +		__array(nid_t,	nid, 3)
> >  		__field(int,	depth)
> >  		__field(int,	err)
> >  	),
> > -- 
> > 2.25.1
> 
> Hi,
> 
> Just wanted to flag that I noticed this breaks Perfetto tracing on
> Android, at least as of Android 13. I'm not sure if it's been fixed in newer
> versions. Looks like the version of Perfetto in Android 13 is expecting
> the previous (ie broken) field format to be there and its entire ftrace
> collector fails as a result:
> 
> E/perfetto( 3532): ranslation_table.cc:133 Failed to infer ftrace field type for "f2fs_truncate_partial_nodes.nid" (type:"nid_t nid[3]" size:12 signed:0) (errno: 2, No such file or directory)
> I/perfetto( 3640):            probes.cc:65 Hard resetting ftrace state.
> 
> For my own purposes I just reverted these two:
> * 0b04d4c0542e8573a837b1d81b94209e48723b25 (f2fs: Fix f2fs_truncate_partial_nodes ftrace event)
> * f82e7ca019dfad3b006fd3b772f7ac569672db55 (tracing: Error if a trace event has an array for a __field()
> 
> and now it works fine so not the biggest deal but this should probably
> be addressed, I imagine more likely on the Perfetto side.

Added context here, it is just caused by the parser implementation in Perfetto
being pretty lacking:

https://github.com/google/perfetto/blob/c36c70c1d4a72eafdd257f7a63e55f49fbc3df3d/src/traced/probes/ftrace/proto_translation_table.cc#L255


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
