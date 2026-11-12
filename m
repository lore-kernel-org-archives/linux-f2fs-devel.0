Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1F606A336
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DjQt1lDl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ahGVzdEc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jPC/eIJ1;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o5eimOkP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=jmRb7yZ9HmhtYlohq9fvW3OQEnMgKy4QArcQLgAx6Ks=; b=DjQt1lDl1sx+62a2yqaADM/JdG
	VFOCmi/Xwe8JbUo7vBB1ZpABeQpe2GzIBeX5YfViruiDIjQeuRuEEVWGYMTcFzIyKJCXkmoG/EV9F
	WllygSWs9TDgoVjtX1/MRK1Dl8s5JP7yEBaaee9ZSQe7cqIQiUoE30thSVVQnb/Vp5xo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRca4-0000000011K-1Bcs;
	Thu, 12 Nov 2026 21:43:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xRcZr-00000000116-14Dm
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nF0KtzX5lY7X7pCJpkiEL7jZcDqHaKsV3dNNI6QftH4=; b=ahGVzdEcLQzGG8Ku2MgyeTP3Rf
 Q4paDresEndTgJ7LWoXymT3eejwf7FPTynkKPEy1+uvbvRL1clu5kaG9hNJKAKqEv+61JOdLDq4Lt
 tphvkWkuzd2yqrBERTFm7fUS9fhPlGt/bHWPeo6D/eOyIq9FddKPORNy+XzkEZ36fTlM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nF0KtzX5lY7X7pCJpkiEL7jZcDqHaKsV3dNNI6QftH4=; b=jPC/eIJ1HBdDNW41ITgkzObJio
 440ZjaIPcFUwtz2fz1zPDgi4grHhFZ9Y4HhJ+ws+Iy6pll9M8p7l75KSgSneJ1TRW8IV5fYodVxn6
 GSzBxTcl91AzeJ4+1dYwvaDnF3IkVdXIiksWLr4g1BVzM3SYjJEYfZRYxayhBJvZLTNY=;
Received: from mail-dy2-f5.google.com ([74.125.229.5])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRcZq-0000000014m-3el3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:27 +0000
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36f936424f2so120876eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 13:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794519801; x=1795124601; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nF0KtzX5lY7X7pCJpkiEL7jZcDqHaKsV3dNNI6QftH4=;
 b=o5eimOkPhTUsVNL2e1imT9M1jbXfvjXRweEdIMgdFqo75sVXOyEAfbkR0Jp8crHwEz
 ZQhvY5U0ekqT9LNuuTIFLzv2CBaEjf593n1T3j0s/LKhzMFPWZPTuixG9Oxqaypgrv4f
 +G4xO7QuhjZtPHKTMha1lR9m2+VSbvpR6H/wBgzAIQVrgym3KzaqcAAQ1joPfSwfHw3h
 f4cKyu0qYwQ2pdmvPqWV06nbg/+7CngoDWk5vjB5ZZVeiUMJA4TULV2fEe8vefjjNSJ0
 h4P84IbixzQwoZwjMjzxjAvRUJV+FNuy21/gbBQjuABKAKot7SWwuD8RExHWPlVvtwkZ
 tqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794519801; x=1795124601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nF0KtzX5lY7X7pCJpkiEL7jZcDqHaKsV3dNNI6QftH4=;
 b=dFK7XIyA0NzKCBgP/pR/0LlUUO4uCI0kurMkItBRq19SP6mGgHRPYdWMrOMDOt9Y3o
 YJI8QkcQKrq5E6/W+mjeYhGiDhLq6smrI1r1HAK2byC2GO0FLVq+zKekhBjBIOgQwAiH
 vSCLi0fQxAbhcD+2mqRDYVov09KSSi5UVQpecRUZsaZhhuyP0vVu+6FPCzoKyAPVbaiC
 XqEsT/pTfGG+WkOrczZW3beQUgFeBBR+0r7t4VvWcYcdg414DEmCV/iy+5l8v1M7KG5P
 T7X7XntXkDMTAiudebB8pLYKQCTQho5icrfcixwhvD3IucMrhYN4fh4Yja/JUeiTvlOx
 PD/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFt0ALqu74ARQT7bhCn+fSi7arriGdqhOZNEVGuUmw0SPRhSh6K7Y1mXgzAfsDkIfcbHJBlvA5SxhP/rtewxNkB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8RMgV0cvCGm0hjVE/5aE8dHLMcvigLnXknue0V/9n3PVn0rskL
 yufSHc7B8WyGEX1j2pjVdXitP1k5xpXkQxwvQNXTEr9tcJvPCflXf5MN
X-Gm-Gg: AYBFou0Zk4VYm3H9vkfv95/AzxjG4Zdavaj+NDMKLiKF3graIbDIwM+1zZlHqpvye6s
 DvEzit1uQU5qjcCxWQFMoh90s3oMeq6p1m+ohK7Alxn0/QalECrbBVKvbDItAwvQ/7E1C0W/HoH
 7ht9Fd8CSZxwaxm2xbFFBeJu4YrKKFMM8QJync+aGEl5cnT3PhL4rxOpwE5eq44nRAU124LihEG
 fBknPuFeoGSyd7xAZDmmhztF4loKx8UNCbIOTFFw56bZX61cmlemWu9S7swi7sGZilKW0krEbs4
 u+Ckw5nHX3VPipMv4x/N7cGwF3TA6h1V0IB/R00Yj84bB0PZXg1MHOl4d3/NR3QhLYymo2wQhCo
 Dj6fFLG8qu4N9vjtKTiILYJ2nkTwZNFlw87ArrnU13aRd/17MXA+Ht0FnzmSkLn+xTvIoSRId1t
 p88uHpGmd+V9W59zOKhzGEQeL4sF3PCMPhdtX81h5Tb+N06TPuTbmdJCwQfP3QiHksIjBQBfVh7
 o+C9y/k/LARg5nTMvlwi9BIjKgV2aWmdqXpJQ8ZXHA0pwHYKlV/MfB75y7pUHi0HwGrg9AcQY1M
 IQ6QzcObMyQHNw9JGFwZOGa277NIwiu6nd+Z3DxAcHVUOTfaulaXL0iRL0/Ch8JO37fUcFeTnv+
 me4J5zl5U9Oo0y0GeQzNx3wYcnmGwydsEHj1vZg==
X-Received: by 2002:a05:693c:4019:b0:35f:2858:aa4b with SMTP id
 5a478bee46e88-379675fc9ebmr349506eec.30.1794519801217; 
 Thu, 12 Nov 2026 13:43:21 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm1194466eec.27.2026.11.12.13.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:43:20 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 12 Nov 2026 21:43:02 +0000
Message-ID: <20261112214303.16198-4-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112214303.16198-1-dennylin0707@gmail.com>
References: <20261112214303.16198-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRcZq-0000000014m-3el3
Subject: [f2fs-dev] [PATCH v2 3/4] f2fs: require write permission for
 F2FS_IOC_RESERVE_COMPRESS_BLOCKS
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

F2FS_IOC_RESERVE_COMPRESS_BLOCKS does not check who the caller is, so
any user who can open a file whose compressed blocks were released,
even read-only, can reserve the blocks again, which consumes free
space.

Require write permission on the inode. inode_permission() does not
depend on how the file was opened, so a caller with write permission
can still reserve the blocks through a read-only file descriptor, as
f2fs_io does.

Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Suggested-by: Chao Yu <chao@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 93f892b11915..9d09ce597f72 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4436,6 +4436,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (inode_permission(file_mnt_idmap(filp), inode, MAY_WRITE))
+		return -EACCES;
+
 	ret = mnt_want_write_file(filp);
 	if (ret)
 		return ret;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
