Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4B3C678DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Mar 2023 06:01:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pZQOV-0000eV-4O;
	Tue, 07 Mar 2023 06:01:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pZQOT-0000eO-TO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 06:01:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0G9utSeENOXNQsWH8wZTXMlBFimyqIDGXh4ifzFg21Q=; b=mtdWKMbF/gHYK661BP/GDNJfpH
 XbkAkDjCZO7J24Q60yHA8TBiDMxcxeYlbYeV2joan4kNbud+22qHs8e0C0L7HZLggzkr0X5xZnaDG
 /9lfAngDRXAYiaPnuYRluIxTwHfGYHhv9WOBgIchD+ba7Jp06IFoCNBURZthIZpYZU7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0G9utSeENOXNQsWH8wZTXMlBFimyqIDGXh4ifzFg21Q=; b=dl2NCvmX4pbzbXuwpYAE+fr40O
 N60qXc7GGILTVjClw78QG7VnKFGfAIFILpyqZhp0GgvbVR7VuAwmqi1apNAh7u7iJiPqAp5shTm25
 tU750Pq7WsGgQZF69g7qPVc1IG/1hAnItY5tFShrgWxEtY5URx9W+NYMaPkKdOYRqoT8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pZQOR-0002Xv-Nn for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Mar 2023 06:01:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2F905B81205;
 Tue,  7 Mar 2023 06:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C92C433EF;
 Tue,  7 Mar 2023 06:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1678168900;
 bh=xlQv5ZF9uz5qXAhO/3nR4xFyeMK6zkkCXsLp/a3Z1fA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=BAli/Vbb+GkkidkJGK7WwwLI7F+q6UAQ/W3ixqtkcUb+DtQz0IyAnW9zd2T3AI/DN
 BuFd4vvufnyWOGbNTBFiZEKOdbOtD/CHc+qH9hJBXRGYbVWgCkt8E4Yj7H5Utzl0W9
 2CFdHG5VLmCsRk69St/DasRzDuohzoomUgD8/pY49UDW7njvrwWNd9iynwMuYzx/Lv
 kvCHPhRwzd4Uz3ZzSP2UxDQNH0vQf2+ch1yCSF7xxwNkcAspjlIBTP8YYIcSX2XS8w
 lm6Z5sdnXHREYs8r5AcYTjTlc+WVkzEWAafeBGyMsoTCag1RBnXTbu1V0wYYkGHYky
 gMAtL3CtApKnw==
Message-ID: <fa4cfb68-5866-ecea-4073-4c5c52e587c9@kernel.org>
Date: Tue, 7 Mar 2023 14:01:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To: Douglas RAILLARD <douglas.raillard@arm.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 "open list:TRACING" <linux-kernel@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20230306122549.236561-1-douglas.raillard@arm.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230306122549.236561-1-douglas.raillard@arm.com>
X-Headers-End: 1pZQOR-0002Xv-Nn
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/3/6 20:25, Douglas RAILLARD wrote:
> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> Fix the nid_t field so that its size is correctly reported in the text
> format embedded in trace.dat files. As it stands, it is reported as
> being of size 4:
> 
>          field:nid_t nid[3];     offset:24;      size:4; signed:0;
> 
> Instead of 12:
> 
>          field:nid_t nid[3];     offset:24;      size:12;        signed:0;
> 
> This also fixes the reported offset of subsequent fields so that they
> match with the actual struct layout.
> 
> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
