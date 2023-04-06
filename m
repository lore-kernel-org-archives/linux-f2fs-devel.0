Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1A6C7618D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 11:33:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkNrR-0006FK-Jn;
	Thu, 06 Apr 2023 11:33:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1pkNrQ-0006FE-Ar
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 11:32:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fyR0t0HwMuQb4sIoRJNb7W09fx7K99y/a4wPKJ46Ieg=; b=Y5Q8FGZDEr5ov5TXXCJzjxe6WQ
 iKjdG2R5pSw3a8iHtCGYX6uCTiYqv5+Bq2T3NmYP6PKigmoUYxHOgrWdTGdSqK3EyB5UkgORKU9TR
 z8oyS8mF0A6vkblO7UlQLM3O7XUtTDTyONLgMfGH9vAwgVNnCvW2IberlSt5OiEPfTng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fyR0t0HwMuQb4sIoRJNb7W09fx7K99y/a4wPKJ46Ieg=; b=l
 VZDqzSjxgJArjTdoR1IC3x2lixQSdH9n3UwU/laPqch41Z2sfaKhyBWHAQiF3Oa1ZZVnhD4EnH5cv
 hjFFNt6+gOx+C696Eyha8tfhYKD9H5fqEBgMLfxalZILN/ooSCAyHrWYQaqYYpPWGPX6eict3lioj
 /6q9XPE3HpRLjHM8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkNrO-0003Kz-UQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 11:32:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8F0C064691;
 Thu,  6 Apr 2023 11:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6308C433D2;
 Thu,  6 Apr 2023 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680780773;
 bh=vhRL0CGCmVCvcXUUnHLaB8Q8ykDyIwZGkVjoapmWwvk=;
 h=From:To:Cc:Subject:Date:From;
 b=C6oSO/yXg3noD4t6sj+X2CGUoPOmksw7Hu6CkwxJR5M3kMoNAw1jbCkZ0vk5D6RbP
 5uGi0a+emRHfgNmMv5Y0JTMviWA1FhwfaOAJ5DnWFYs48aiKqZf9HXZxvY0E79eM6H
 d93bp9792UUqwG5ysGWYiNtsUyv0XSBXGQn6NbRn21OYUwdey1ChoIIs67f9TKvivI
 NOKPz6S5Ng3G7mlCpe6AY4fcpY/io8AIqBAzJ8mGAQboRKVfRRBIT9FpOYAkh8EMLj
 vmuvlTuS+u0NxbfH2k1hitA6EdPVj+KNkiU2B0wYz0k9dz8IMbuVkxCIWXCbhXhcAQ
 fgSPop07GfWFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  6 Apr 2023 07:32:40 -0400
Message-Id: <20230406113250.648634-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1pkNrO-0003Kz-UQ
Subject: [f2fs-dev] [PATCH AUTOSEL 5.15 01/11] f2fs: Fix
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
index 4cb055af1ec0b..f5dcf7c9b7076 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -513,7 +513,7 @@ TRACE_EVENT(f2fs_truncate_partial_nodes,
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
