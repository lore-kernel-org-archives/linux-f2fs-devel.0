Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF06606A33B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LK9ni8jV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TcrBcHfq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kEDaV2kP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WSpxQtKS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=ukB9c8C7NOmIFLjR+aDM0YVW/2HC/y0yVcX79Fl8UpM=; b=LK9ni8jVhvUfE5cU60b5fSzW8R
	ZOBkOzWfSIjENV8E+cmbTVuep0l6pGEERcj+1JKyuRGDw/q4N8TNuiMEt0TyjNPS5WcwX+PU2Ey2p
	YBAg40Srl8zPinarrGtx4Bki82acOxm1Er4I4tL9FF40UXizVltGATEmTVkLsJ0Agn+w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRca0-000000006BH-02vw;
	Thu, 12 Nov 2026 21:43:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xRcZp-000000006AD-03n4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3d20zwRz5YNuFbeVdw1xQneB3kQbFqU3BiherwQ14Wk=; b=TcrBcHfqnGdqfr4/hI+ZQ4cK8z
 eQsHVuHdADDD1oR1rBLlp8fIJq1L5mBnlSNU7mW352Ihu8G5rtxAdF7vCXfa3tbLO29jnQmifM1Ml
 n/2s7qkVOInvgQ86yTneKbC3J5heyLWw1o9HmGIa64QUgvJSsM4rlajPniJhl0rHoz94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3d20zwRz5YNuFbeVdw1xQneB3kQbFqU3BiherwQ14Wk=; b=kEDaV2kPREuKZdmT669Warbouf
 L8lHWSOpF4pgoy+dk7qHCf/lSncogVPBF3GBZVWz5MSC6MZY3OCMlFQFey49qW6/hh0oC11SnVwBk
 buwP1/ry5tv226DGcc52lxu7PBagvCG1rVBUnlOAF4H5CE+3ev709dOKVhK7rsWWGlrM=;
Received: from mail-dy2-f7.google.com ([74.125.229.7])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRcZo-0000000014i-1a9B
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:24 +0000
Received: by mail-dy2-f7.google.com with SMTP id
 5a478bee46e88-36c9b5c6faaso192600eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794519799; x=1795124599; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3d20zwRz5YNuFbeVdw1xQneB3kQbFqU3BiherwQ14Wk=;
 b=WSpxQtKSGrYzGttrxFBaUgKXTVQThuJmXxz/biLm7QPnbj7/QT9WVIG/urP6cfB4kZ
 PEzhhsevr/WmPXuo1pg+Jqsxt+CMPFjOVt6Z0j9QdsbiuSN3Aq47r6n1i51c8IWd9rnr
 g9UC5Cac6dHUhD6u17O115mpE5nFz9j5BckMb/JFOcDHEnFBW+BTj9Zp6PwJ5anWh5d8
 OSNTQYfwrwlvQ/DuLiKryNVdsqQLcpF2aYOO7oYH1ROVzodsqFAHm1DBcNvdL0Fcr5kL
 tQU+B8D3Q+5yUw1oKJe2rCUaSe1NnQsXEJMmvQBol6pIElQLtse3/Iu6GsfjgnIBC2gZ
 dpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794519799; x=1795124599;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3d20zwRz5YNuFbeVdw1xQneB3kQbFqU3BiherwQ14Wk=;
 b=GtIs9NTzg0EP5WB70S04cYXN21YJ+FRgN1ab22HjzQG0gp3MACpNRjngx2i9zW91FQ
 XmC6fr3hMp9lHU7F+GPR/7OEvdkhO6hAquFCHeZ0McVsRUQTXgLMsPZlbJBblPrWhH5M
 mi2QqeYlxoVuvWkoXduIsFXXfj7VQDZrL9pi7SmICRiBsNjCMbEym3o6CfKWSesmLHSp
 6qqcgxRYCOSrCbP06XTwRplBofoR2ZeaFV60RZEqyBZD4TfLBow+nVdoWfZlLH4AKzpx
 maUt5ZIucDCCtHtTu2p3icaLDqqr0sRtH1mQNKa4FDriazHcJliF1R90l8d/iPBAkkIh
 wgCw==
X-Forwarded-Encrypted: i=1;
 AL+hErGNQ8F3LHcahDrlWukG3+u79LbNNT+1qKn4dGFkwEzpb/0U+eJxgX9wxBRIGOwDim4rt7hTUDCxOfKAovuRZT6C@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9RXkpP/FudepzjbKtb4W4pCpFFJuO9xRaKgb0Di2G5yheQd+Kh
 rObEwXKYkm2LByq2u2oOnR8mShXOu3cPDw++FxLYMaFhDD+UoCwPacSg39gyq84Fj4AdtA==
X-Gm-Gg: AYBFou0NUGDQ/S/+FoI+C4GnTyT3CTXZ5v8xZlwNmnR9DUCf+1juVSHYX0XtlGh6n/g
 Z22DBcZxLaWtXmO4JbXjCo4aZM0frU0AGuWMzEhFrBQcChNiBZNJpXGp6Z7qES3IavoYhEjr4ck
 mgJzblFkMeqHwNjekGCZ5DHmNueatRWlrTVQ0cypVEvJj2qGJXRQF4oPfjaiZQDvykE9su5Myep
 VNyij4T85zvXWwkdEhj772ZY1dEtE2aJCmE19TMwS4cx2PBBiGL6TtlAWmZQSKJ1+LXw9+7uToe
 vnPe62nQm1BsnVa6IfVV/G5CYQ/1rRqt6r6BBXBz/xUty8VNJG5hWEctTHqUVyGLwt3I3MahSg5
 gCfI+nkiFXHZZjp7X/zhZOSlfyyow9F5B085uzlHef+4+xtVw5ToJJlTm3+yqBWd9WVekrhlIbc
 52RlzaT8O5R16m0sm+n6hSZlfxly4FYg41a0D7s9OqxACyRy3o1y+G3d9R/AhN3tSPa4g8SnEZs
 PuAr0lz7KroQsLhYRW5hO+VxfjrA2+EQldp9sIjyUERQBtT02jAw204pzrx22geu5XsaCQLbmsw
 kvopTnBpWTS9Bbb1TSfV+EuNm+kWgbKBOe+8t5c600B/455e75nQZiegdhzpLKxWpkH2atiCQD3
 +o5MeZ3aE8wsPWyjtF8yyGVleoVooNBtqbXiqSA==
X-Received: by 2002:a05:693c:829b:10b0:370:ff2:f78d with SMTP id
 5a478bee46e88-37965ca7d77mr461383eec.8.1794519798639; 
 Thu, 12 Nov 2026 13:43:18 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm1194466eec.27.2026.11.12.13.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:43:18 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 12 Nov 2026 21:42:59 +0000
Message-ID: <20261112214303.16198-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRcZo-0000000014i-1a9B
Subject: [f2fs-dev] [PATCH v2 0/4] f2fs: require write permission for ioctls
 that change per-file state
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, dennylin0707@gmail.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

F2FS_IOC_SET_PIN_FILE, F2FS_IOC_RELEASE_COMPRESS_BLOCKS,
F2FS_IOC_RESERVE_COMPRESS_BLOCKS and F2FS_IOC_IO_PRIO change the state
of the inode behind the file descriptor without checking who the
caller is, so any user who can open a file read-only can change that
state. Each patch requires write permission on the inode in one of
these ioctls.

inode_permission() does not depend on how the file was opened, so
f2fs_io can keep using read-only file descriptors and does not need to
change. It does refuse write access to immutable files, so these ioctls
now fail on immutable files as well.

Changes since v1:
- Check write permission with inode_permission() instead of
  inode_owner_or_capable(), as suggested by Chao Yu.
- Split into one patch per ioctl.

v1: https://lore.kernel.org/all/20261108045722.12091-1-dennylin0707@gmail.com/

Hungyu Lin (4):
  f2fs: require write permission for F2FS_IOC_SET_PIN_FILE
  f2fs: require write permission for F2FS_IOC_RELEASE_COMPRESS_BLOCKS
  f2fs: require write permission for F2FS_IOC_RESERVE_COMPRESS_BLOCKS
  f2fs: require write permission for F2FS_IOC_IO_PRIO

 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
