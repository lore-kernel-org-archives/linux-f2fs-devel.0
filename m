Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA1FC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jun 2022 16:56:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1WJm-0000ox-3M; Wed, 15 Jun 2022 16:56:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1o1WJk-0000oo-Hd
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jun 2022 16:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ma4ZZKcuE64G3ZIVQ8j1G2RFA7A0M1CW4IUGujwHO7Y=; b=XrX+QJYWAev2RxXp/H7GzV51lr
 rPxlDx4p161YvnpYdqVMLoIsOtid4LBoDdgc5ClgHGi6mamqzfX34jZ2Zp7t6C89nupzbFA76b6VC
 xb4XfQ3QEUYE+qCEtUWgpvzwaPUogPGIeeIi2GP0ay6p7/TRQ2GjsflDrqc4VajWUf+E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ma4ZZKcuE64G3ZIVQ8j1G2RFA7A0M1CW4IUGujwHO7Y=; b=dVuV0BjAJBsoZ5hYK60NK/pRFr
 /IQFneeWlJDkgLCaB71uCeSfdBzfZZUZ/tKza6wEFZxFIsSQ+Wt4z1PqMMy7pPr956tNA9XkrfvpQ
 eQXtZkfLqk+FnTT3iw6ZkgOcwpLVxAt1KoIu5XzOLR0ixanvSuXlUxEahDA7XQooF0hA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1WJb-0001LE-JO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jun 2022 16:56:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E5675CE2157
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Jun 2022 16:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28283C3411C;
 Wed, 15 Jun 2022 16:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655312173;
 bh=x1Pm/QzFS7c5e7qvuVZ8ue+fyFJvRacIEHdKil0oyGQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QHyPYSYfsHuJygTS5DDvrKMzvK3L8+Ogax0EIg5YZe3xGt9QdNMr373aqUgQEv2Gq
 KOPHnBPgmrRRXMbNN6eyAErFULAGj9/ebk1Ielr4ixt/H/f+w3cqfhqD5WUUtMaHpu
 PgA56N4+KNbo+JefQ26y3WvuWjFuIzgs03oBYhGL4Lnmamg+QCuyKegPPM5h+awbQ3
 PNqES/4N58aMG5F10iGQo/quj+CaXjJVMsQ8CrLi8Ty744Bu3CCODOFbmtNy6PROnK
 Q51BBLQ9QgUTPXSRk4TVGBdK1bPDk2F2ccQhUPVDK4fRny9ofdgtZU4e2fr0CvrPOp
 /Y3GVpSdGfA1Q==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 15 Jun 2022 09:56:10 -0700
Message-Id: <20220615165610.1074259-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615165610.1074259-1-jaegeuk@kernel.org>
References: <20220615165610.1074259-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1o1WJb-0001LE-JO
Subject: [f2fs-dev] [PATCH 2/2] f2fs_io: add dsync option for write
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 2f0fc7b25d41..e7359836b126 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -508,7 +508,8 @@ static void do_erase(int argc, char **argv, const struct cmd_desc *cmd)
 "  rand          : random numbers\n"			\
 "IO can be\n"						\
 "  buffered      : buffered IO\n"			\
-"  dio           : direct IO\n"				\
+"  dio           : O_DIRECT\n"				\
+"  dsync         : O_DIRECT | O_DSYNC\n"		\
 "  osync         : O_SYNC\n"				\
 "  atomic_commit : atomic write & commit\n"		\
 "  atomic_abort  : atomic write & abort\n"		\
@@ -552,6 +553,8 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 
 	if (!strcmp(argv[5], "dio"))
 		flags |= O_DIRECT;
+	else if (!strcmp(argv[5], "dsync"))
+		flags |= O_DIRECT | O_DSYNC;
 	else if (!strcmp(argv[5], "osync"))
 		flags |= O_SYNC;
 	else if (!strcmp(argv[5], "atomic_commit"))
-- 
2.36.1.476.g0c4daa206d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
