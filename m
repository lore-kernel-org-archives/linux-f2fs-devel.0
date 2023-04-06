Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C9BC77B6E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 11:34:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkNsY-0005U7-Gq;
	Thu, 06 Apr 2023 11:34:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1pkNsW-0005U1-UK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 11:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SrD96Qo4ynCPPalZH76cflngfcobubTBhZZEAl8zvTg=; b=FbzTIvtmvsRodZOrLx1LneEwBl
 WMeRp5/tBjoSMEQjYvSYUjGcAu9Pv5kUS5WXpB6Bciv+yCZFnFl3GkJ2gvOU69gXPNtH9L66iB4or
 phNvGHsBuv9Q79Fcp6QScuYXoEBh+1QrNtTJAczWpR/6y1hqKdxtQ8LvX7tyZ4Dp19nU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SrD96Qo4ynCPPalZH76cflngfcobubTBhZZEAl8zvTg=; b=K
 DY1HHOESyGk0+Mx9uzzZy3g8FzfwTC/RrVldaHjN3znwteRQwpURnEihar5d1YqVZSdgA+TLjKB8v
 zwsx78kw05Nsj6UNJP8v0Or9LnEHhwMTP1gd9yIoVdM6VmlSNXhdR7wCC8EgzWpqSGA9G97pOTx3+
 JWtsz5iakh81gNTg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkNsX-00GorP-8s for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 11:34:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DF05464636;
 Thu,  6 Apr 2023 11:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4B8C4339B;
 Thu,  6 Apr 2023 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680780843;
 bh=FrPrFRzIb80pwqGPPW/9W4CngxldpXYwhVu5k4UI80Q=;
 h=From:To:Cc:Subject:Date:From;
 b=sYnM4NjzMbhILoUjrkvIKXnYDQlisejccKwGKyuExp+d35Y/K2HLxIH9aNsf9CILI
 m9tVgx+o4O0CA+1K8e94Rq6KdehFLnUJdNlhibf2gDUKL1hKXwGKJ9Z6qMeIQrWssS
 ucu7Mf01HqgevsqxmTkIkYdZn+jbo9LgkmG3ILGenFl9yjQndW63e80e/xRbsVulfy
 eKcu7QHc6TaJXtNLu7Jqx7wAvOt1cJnP7SmJ3m+SyRwVX2pjXqjr6CZw4gUe4bpfvw
 /v0eLR33jW3RX8S51Xn8BtUzVhfRQNrqOz2JbSpR4PxISm/SlU3qfapkNd25Veur+9
 fae+mtL1WfkVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  6 Apr 2023 07:33:53 -0400
Message-Id: <20230406113400.649038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1pkNsX-00GorP-8s
Subject: [f2fs-dev] [PATCH AUTOSEL 4.19 1/8] f2fs: Fix
 f2fs_truncate_partial_nodes ftrace event
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
Cc: Sasha Levin <sashal@kernel.org>, rostedt@goodmis.org,
 linux-f2fs-devel@lists.sourceforge.net, Mukesh Ojha <quic_mojha@quicinc.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Douglas Raillard <douglas.raillard@arm.com>, mhiramat@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Douglas Raillard <douglas.raillard@arm.com>

[ Upstream commit 0b04d4c0542e8573a837b1d81b94209e48723b25 ]

Fix the nid_t field so that its size is correctly reported in the text
format embedded in trace.dat files. As it stands, it is reported as
being of size 4:

        field:nid_t nid[3];     offset:24;      size:4; signed:0;

Instead of 12:

        field:nid_t nid[3];     offset:24;      size:12;        signed:0;

This also fixes the reported offset of subsequent fields so that they
match with the actual struct layout.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 52e6456bdb922..098d6dff20bef 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -498,7 +498,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(nid_t,	nid[3])
+		__array(nid_t,	nid, 3)
 		__field(int,	depth)
 		__field(int,	err)
 	),
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
