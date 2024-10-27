Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31910D13561
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 27 Oct 2024 14:06:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t53uj-00089t-Th;
	Sun, 27 Oct 2024 14:06:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <algonell@gmail.com>) id 1t53ui-00089n-CO
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Oct 2024 14:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ciP5PqyHVqbZ4ar5lDSwgDPW/+/+QdOUjUbcyphWzWE=; b=LyKmQ5OCR0TeFvJfAOIJz7Rq9d
 lpcocgsAlAAZxsB6aS58tOllN5WttpXSTAlks3kFQaCh3wjOb8Fic6KQwcSV7EcBbhsiTbRRYQVYS
 rEbV62ge0KDWjzAMsZNstb8cu7oodh1rmSbCd1P5AV3MaaXISxQPzISworDxM1+KFVr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ciP5PqyHVqbZ4ar5lDSwgDPW/+/+QdOUjUbcyphWzWE=; b=i
 +Cmv8NQjptKEzMMcZR8W26uG1jxvTl1EMyc2Nvb+RZRxlzMdXMeTTrwHn/TopU60FYGSqB2+Uufjn
 xN97LG58R7ABfBbCVWU5hjBbkkovs106nGBKQu+4zlIqbLv24of+kWS/rCQGMlESJIP+jZEMPJV1x
 SGfozx7HDyiI4ppQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1t53uh-0000ct-RO for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 27 Oct 2024 14:06:40 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so2455533f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 27 Oct 2024 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730037988; x=1730642788; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ciP5PqyHVqbZ4ar5lDSwgDPW/+/+QdOUjUbcyphWzWE=;
 b=nsIcqZHDeThBahqOLdAugAFtBunlmm6fTstT3gVZN+d+PEY/jUYvlfQi8bzITY7Tt3
 bz4ERchOWjrxfsnDfCrgPuNBvUxnUQ4zPwZBooBiAdzqJDTfYu3E1RdoQZ+4zb3YriMO
 e1NIFt1nwxjR1hpnb5AQ1a06qyYALHqrJ9pysL12HBePj4V5Rk+dWc3bBKNDg597fqvg
 QXmzrFikE2jOJLfxGjREhtaIuxfMhvAnZ4Kx7yK0Yw+hApgWzDGS6fH5MpQyDeBMeVuB
 cxgJcbyvm5zqc1EqxGF5rS69MQrR09FqdViHRX8DVwUmZopshF1zmIuaANMjLa1+G5F6
 Op1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730037988; x=1730642788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ciP5PqyHVqbZ4ar5lDSwgDPW/+/+QdOUjUbcyphWzWE=;
 b=W8dGgrh39tyPZplmEdsnBP9WrvQZ0dorD76i3QJljZhfUcNQ1x9fpSgDmy50+84pGK
 iPrRSuYFKKhmOBbWZIwoVzjppB8qmVQNGURyTA+rCwu+0Th6uXH5zyptIeSJYzOje2uF
 TH0rHwHS/jYMICqyjtnqYSUJ/i8kKrPoaXZSbnP6Q8piPeilRg+e22WhMx625CdJRBW7
 xCgLFyJWHgkmvL98gkT+Kp3UgXZs/loDIGe1Bv/tuD3WMoiYaw6SNKPo8iiUCep+bJnX
 qiZKnyzXSMQ/F0ARjaY8ugrAv1QZWTpCI8k+Bv30s5ZnETBNoWEiW99Yj6AtgqFDtjjX
 pB+g==
X-Gm-Message-State: AOJu0YzuF4Pu+j7rWv9fY3ylvQZs+sA/ds8LquG07NgYosJ28Z6JXwZi
 KRSsabNdJkaAaGQNRY8GFX8bfiCA+jeqNLOQ8JvL2mc1dABOoALn
X-Google-Smtp-Source: AGHT+IGa9wvaZ5QuHXadDbtM1Tfk0wq1icLe9dx7brgIhawTZ5Q9vy/wi9r4O8n+YU+MyNdylirWTA==
X-Received: by 2002:adf:f050:0:b0:37d:4657:ea78 with SMTP id
 ffacd0b85a97d-380611f5b86mr4049920f8f.54.1730037988207; 
 Sun, 27 Oct 2024 07:06:28 -0700 (PDT)
Received: from void.void ([141.226.10.223]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b9d70fsm6871843f8f.108.2024.10.27.07.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 07:06:28 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sun, 27 Oct 2024 16:06:08 +0200
Message-ID: <20241027140623.24802-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.149.g3e3ac46130
MIME-Version: 1.0
X-Headers-End: 1t53uh-0000ct-RO
Subject: [f2fs-dev] [PATCH] f2fs: fix typos
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
Cc: Andrew Kreimer <algonell@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Fix typos: datas -> data.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 fs/f2fs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 546b8ba91261..9dfb577d695b 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -598,9 +598,9 @@ static int stat_show(struct seq_file *s, void *v)
 			   si->ndirty_node, si->node_pages);
 		seq_printf(s, "  - dents: %4d in dirs:%4d (%4d)\n",
 			   si->ndirty_dent, si->ndirty_dirs, si->ndirty_all);
-		seq_printf(s, "  - datas: %4d in files:%4d\n",
+		seq_printf(s, "  - data: %4d in files:%4d\n",
 			   si->ndirty_data, si->ndirty_files);
-		seq_printf(s, "  - quota datas: %4d in quota files:%4d\n",
+		seq_printf(s, "  - quota data: %4d in quota files:%4d\n",
 			   si->ndirty_qdata, si->nquota_files);
 		seq_printf(s, "  - meta: %4d in %4d\n",
 			   si->ndirty_meta, si->meta_pages);
-- 
2.47.0.149.g3e3ac46130



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
