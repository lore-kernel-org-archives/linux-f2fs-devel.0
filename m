Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2F606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UaifX0SO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FZi5y3ea;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=biDS7Uvj;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OShJeF+M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=ikhOqpFqQbeA7kYGO1y2tccViajl2d2F+RXtHV6MPlM=; b=UaifX0SOG41oKFjsVnd08tQwwy
	NLZuZWXqEPqez3LZjM77nWL+p47tcVniDLwNiBRMWkI8C/OdDSfNcYtiJDtNT68c8wxNbUjwYy7sj
	VxyW/v/G12HqYWkJjWn5SYFobQ/7Jkin6ZnJ/05Z3GRhALZVi8mzXwKS5tlR/bLRQwYU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xU1tg-000000003cH-0SfH;
	Thu, 19 Nov 2026 13:09:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xU1tf-000000003cA-0Dw5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PphJKGIIcVX/9w8g1yp+hTGjPMtalyYrGbwcnLjbZ+M=; b=FZi5y3eaCZV/3rTd/MtB2iDX5O
 yHJpa3kBEYTEA0QkFR2LOhotcgAmgKjmUr/zhQseQJy4CqSREYokPny8rhbAbm2ohnhSaYZowbvMI
 XIW6orqHsz5DMWqtc9AHKbecSgSa3B+9Cv2iUx7NbBS107Yq93UFV9AuYEtngHGdsYjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PphJKGIIcVX/9w8g1yp+hTGjPMtalyYrGbwcnLjbZ+M=; b=biDS7UvjIGLCbPU0U58hNIeSqb
 K5LD8dLERNPj6dCId24kZrTS146SNYHJsUPKZIIxFsGdA0h8zpPoCtKkanmwDrtDJmRYM3s/IF7lw
 jkqq0W4GY5zc4CYqCOWCvgfK0qOU/W3aX6NZIZcHVPf5D1X5MyhOq+7lpbXaj0fctL9I=;
Received: from mail-dl2-f10.google.com ([74.125.229.138])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU1td-000000000q4-26nc
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:09:50 +0000
Received: by mail-dl2-f10.google.com with SMTP id
 a92af1059eb24-17c2de6994cso169662c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 05:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795093784; x=1795698584; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PphJKGIIcVX/9w8g1yp+hTGjPMtalyYrGbwcnLjbZ+M=;
 b=OShJeF+MPUr3H5GhRyxFWHuaMNlctRLh0vylaLkzdaXOPrnrkdJ0aBMmy+JImESkFl
 vwvzEGZoMJc7swyFKaX6j3SoQbDiei872P9HZqtjEVU5tR3vfMqWIy9w3/LpoByQ+e5e
 A4xlVyQHnybGx8z5H1GEQh+NkY3Kl4+OS+voVoFwiChMd9O5ccDnZOeSY7jM1NsLtIwq
 rGYICglQZCyyfONxvgolNKgbBEEyAVi8+MnPiQ4iZbtNLrEPQDrJVaZjq1CT1ZWdemDP
 7JugB6cwTgYMfxIl74sMbBh1vurX1EkCbFUn6BeqnrDCnI0jE3RE+BzKiyMBkZJjskqt
 Fx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795093784; x=1795698584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PphJKGIIcVX/9w8g1yp+hTGjPMtalyYrGbwcnLjbZ+M=;
 b=zX4vEUpyqH9RdFvmM2I0DzZlGi1josmQyQ+UtJwqxb0wHS9rNJQQjnb8+8c/gbcJdF
 ZVWd7XYg9EQ3LYRcDC8gakuCN69/SqfmjrkQw6BIPbS6sJ9MciBthS15BDZijAo0iOr1
 je+7EPHh02UsdLTVQGd7EqRyPyQLlLXRYIrQeu3m61vWBWa1bYiWv/CVNSovBehZRb0t
 ImtBOPEXIWhIYgaCIhMJ/Aegl7s8sv8Qv9wxBWHW0MQVBBNbTFKY0fNd4UTcJ6nI5gYu
 fpKTu6I7dg4OPJkgOILWALYnPza9AZ484f0xcdsZOWPqNT8iKliKE2ZgaLZX9psVPtYc
 HiaQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGYVUaLfmvBDQDkBobb0fmcS9gQoPKNPmMjNlRJJDN1SS7SKWZAGSg7mqLRKj4/7I+mlMVSJb42KBx0yPNy0EKj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+OzjLQJz3gQGYLbblPcWMx60fI1AhSKxmepYQQZ+dEPX4pXnZs
 enJ7AK0mFMW6BvqJni+l1vTCgoCE00USgakQ72YQrvwsOGoeJZcEuc0O
X-Gm-Gg: AYBFou23uhCRxAZb/xVkdsM4CLu5BxWcL0ESNtZ9a+c9GFt5TXCHWqJeM1eBnqJkgyd
 SSzKcmj9//Sx52kfFa/ScvH3rGgdxmyWZ5ZqFCHQgrqGtWLpcZj1Bc6uV+J9UlulusgRm7JcaiM
 zb4Ol4XF9hyOc6iSl2flKAyLBgM+fUzxvZZTZrgRpYxs7UQd7KYDNIsOMUNZh3+qPtkNZLhsSLq
 PNfXtmc0IYTBU1vkcEQfMupCg0bDQ1ezwExtzRJaHylcjRdG0ydh5+9mNB4Qs4bqdt7y1JOJoXf
 Xn29Bf1PMMEJulQ38mLVmX/HYt6UesrVefwBX0VhqdAf7OKIaDzpN2GZ0rCX2tXvvA8cX8AG7Uo
 XaPg7459sCnWGdoGq0MVniAHCG9a3NDnAa+PSeAhL+D4PhHtjnpEkZIZfHjtgtBaKQj7vkc4ukA
 MG3bCa+C8z30flK2KsjljthFrQeapMPEhBwmAoCw7g4RB5Y0U3pv/lXC8oZ8ulrddMZUvIIoyk8
 4lewq4u5zy1HO5Rt+HycTwQQNvGSNcvEgbaJ0LOLRVut9plJTZn714sPe5XZAmKMQ4pp67dNjIU
 2gtaFZfgZgCg3fyG5xruaGp+YEyS1IC8DUYoT4px5KJnXq/Teluw7LfOFbWSszFTalftWQH8WbH
 2ZAocZLrEqq/MPX/uosI8+sulhDlbreNiVfR72w==
X-Received: by 2002:a05:7022:7f0c:b0:166:b307:5855 with SMTP id
 a92af1059eb24-1b543b316aemr7096471c88.0.1795093783741; 
 Thu, 19 Nov 2026 05:09:43 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm19601165c88.5.2026.11.19.05.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:09:43 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 19 Nov 2026 13:08:14 +0000
Message-ID: <20261119130814.79404-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xU1td-000000000q4-26nc
Subject: [f2fs-dev] [PATCH] f2fs: reject immutable and append-only files in
 secure trim
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

F2FS_IOC_SEC_TRIM_FILE only checks that the file is open for writing. It
does not look at the inode flags, so it discards or zeroes the blocks of
the file even if the file is append-only or immutable.

An append-only file can be opened for writing with O_APPEND, so a user
with write permission on such a file can erase the data that is already
there, which ftruncate() and fallocate() do not allow. For an immutable
file the same works through a file descriptor that was opened for
writing before the flag was set, although f2fs_write_checks() refuses
writes through it.

Return -EPERM if the file is immutable or append-only.

Fixes: 9af846486d78 ("f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl")
Cc: stable@kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..ba131c6f9a54 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4582,6 +4582,11 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		return ret;
 	inode_lock(inode);
 
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode)) {
+		ret = -EPERM;
+		goto err;
+	}
+
 	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
 			range.start >= inode->i_size) {
 		ret = -EINVAL;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
