Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E4606A336
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kaCVOMdi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DwI6tVrO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FsFN6Zo6;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PkJ0sKQR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=c+KJrSEvGCm8UReJeZYwojVkKG+QGNw3W43tELWkDp4=; b=kaCVOMdinMx441+VKKfkFoBmc5
	3/mzWpwiDiJDFLTmva23BYjxpqHyheyf1m6JhCm/NEuoL/Zhh7OEIJC6Zsd7pmSyiHlUYUtTee9l3
	8FvuenWwIIafI9rcLcOppFH/U1xLHpW8jh3XOo0uVjOSLDzEfmt0Qh9xfuxLtvtEBgSM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRca1-000000002vh-2WMx;
	Thu, 12 Nov 2026 21:43:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xRcZp-000000002vW-2jCV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WvUlOeDanurqLbDS6/09GivlgebJIQFHQ91QWYUQty8=; b=DwI6tVrOgHXuC6URPosjIFMyun
 DuKpefISV3JwlopUN2uI2jeWTTFfNh48PSNpzZsx7fr+IYWY+MWYgUMDf8PjA4UBr+aloGtEiE0he
 JeTPdD1W5NCetHQVS/h9g+vXli81r3HVY+0d+zVyL3V2SHoz04eKMNuF6EY3bPEzBXMQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WvUlOeDanurqLbDS6/09GivlgebJIQFHQ91QWYUQty8=; b=FsFN6Zo6WT3M5+Zt3GK13SjZAq
 62ePE+yanz7bl+C4tjQFkFHxljww8tqlQucSuCPMnPI+hmlGWAsFag6HOb7xJT2cixJ6SpiUcW0Hy
 ijXYnBI7T7MtnRWFX0MmZ+pKOfCwpjmhqY+3ADVZ66WaCK5QqMe5RNsC2HaGC0JbPTUk=;
Received: from mail-dy1-f194.google.com ([74.125.82.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRcZp-000000005NM-19E8
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:25 +0000
Received: by mail-dy1-f194.google.com with SMTP id
 5a478bee46e88-37198ed3727so1658709eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794519800; x=1795124600; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WvUlOeDanurqLbDS6/09GivlgebJIQFHQ91QWYUQty8=;
 b=PkJ0sKQRa01epIs/B1kGiUZ7qYM5o/VrcT8Dgr4L82PIAFGX4V5W1JBXSWRRFZlKLB
 zWURW4Fysqd5UlW5/lALtgfRPgx2iMwCas7SzA6AHX0hOPOna8xdwnlq5vqq9GGx6/t1
 7DkBd5hq4IJC9t+MDbQBxx6W+DtAJxdh+HycZiIWv3Yjb0G7jQQ8L5BQRWsUuO6uOPG5
 0HjFj9Iq7AJQ1HtrxNLGmZrsfgRMnuSWhwNvYzTTz2othH+RUfwKbLBFMYe77nIDkmES
 NgCni5BTMHi1x8AmqgcSE2wUJXXFgBLgOWDRQuxM9A8EOXXiN3XayFouc1XZuT4NVK8g
 PxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794519800; x=1795124600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WvUlOeDanurqLbDS6/09GivlgebJIQFHQ91QWYUQty8=;
 b=YUCSAtjcUZzKX4hEU+h2kR/jix1ujjqG4HdkECnPUPsDVApDjJI1Ip3Hhcj8LBducN
 pBqyPsXenn+bhlRnvvIZLG1cEITbYFr8FdeTTlwSziknxDDfyW/RaayTDnwzKN92yBbS
 zK+XHU7rQIeWkfqco/T8A23sLGNh/miHcPCiRvYPj7ye8645khnU2s/lzMHad8owY1TF
 HXmRcT4woV+P2c96ID90UZa9ckjtnLGM7CBd/C/9YajvaeWoBQ94TOVyl01pG6/Ei57z
 ok51TvTz+A9dnb7TfJPKFuyoVH2BOMLRWVu+xvWFycExqGNpxg/7XPpfeYktYdWISBdS
 Mkkg==
X-Forwarded-Encrypted: i=1;
 AL+hErHFjz6UQ2wZuEj1GNAyOx1aEYqElO2FDNQK9lImOCNKYYHlDz8WH99KVjak+lmacQYMsWyLvdzOi0Q0OTwRSJfj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+qhqMNZluAQuxC6Uvv4xOAhncswYxs2GJknXg6nBoi/rRtxIKn
 CCQIbA5IpAYejQiJrvpCSVZojhiqs+/jSjjUHLmKJr/UtxbQ+kpldcYs
X-Gm-Gg: AYBFou3hf2DFVJfieWzx1lJowXCoqFANuotvPLUFSpnSrjtylsXPRQzjTMhUhWJKbk7
 ZhaKyfPgD+Ymg0GxoBTyBBoOBkspBwg2TVj6cr6imqYt5UWhewvZCN9GMbZkYifxS1fN0M8oMAk
 ugh6X0w5MHw1Eyuu9mukXXKHU6F2RgNj5znqeWcar5XiSaQJIO6Vc2DTLmhDGlcsFzliLyozgmS
 sJghD/AtywI2eQDXJ4VxSuPlPe1aGKZVT6VUyfhen4ePonhucv9Vifx/UdFk/WkQkRF12vJSsnk
 E/H1es9PyOuzw/FWykeAVL8JnDuqYqcsg1lkClT97snunq2NN9erOZZrLIL3glY5MZqfzArDKfY
 ps05kNTDEgUhRh5PLF3HFK9Z3A4G7qUM58RYzy1NwA7VXsUKgxJdWBfx7fvrL+lbAp/kL90D5g9
 1ZejIWBGohlsoudypPbBF/Nr3lhf/2Uw3gQXv5UK9VQjiRcgWB/1WU5rqHtN5vMICAO0ScHDT3V
 JuiGr/jLcEpPjs1vGPPjXzTAv+XtI2X/ZtwXRmGjHm/1aWZvB59g8G/bfPVWq6PBKcVie2r+eyn
 CLmUX11ISONeR4EDg0m7i14JNss04GAYhZDj64S+DYXtPDdczAw7JGNdUTlFTgmyl6QzTW+iMWw
 lprlUZ/e8hcIXcmj0I91yIqtDjMOc47BH4lOQ5v4JZmTpnEOjw5Nz1nwnfvw=
X-Received: by 2002:a05:693c:83db:10b0:375:6fed:8e71 with SMTP id
 5a478bee46e88-377e093ba7amr3053481eec.7.1794519799484; 
 Thu, 12 Nov 2026 13:43:19 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm1194466eec.27.2026.11.12.13.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:43:19 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 12 Nov 2026 21:43:00 +0000
Message-ID: <20261112214303.16198-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112214303.16198-1-dennylin0707@gmail.com>
References: <20261112214303.16198-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRcZp-000000005NM-19E8
Subject: [f2fs-dev] [PATCH v2 1/4] f2fs: require write permission for
 F2FS_IOC_SET_PIN_FILE
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

F2FS_IOC_SET_PIN_FILE does not check who the caller is. Any user who
can open a file, even read-only, can:

 - pin it while it has no data blocks, after which writes that extend
   the file fail with -EIO;
 - unpin it, so that garbage collection may move blocks that a user of
   F2FS_IOC_SET_PIN_FILE expects to stay in place.

The ioctl checked inode_owner_or_capable() when it was added. Commit
aff7b628ac2d ("f2fs: set pin_file under CAP_SYS_ADMIN") replaced that
with a CAP_SYS_ADMIN check, and commit b13bdf03bb80 ("f2fs: allow all
the users to pin a file") then removed the CAP_SYS_ADMIN check, leaving
the ioctl without any permission check.

Require write permission on the inode. Users can still pin files that
they can write to.

Fixes: b13bdf03bb80 ("f2fs: allow all the users to pin a file")
Suggested-by: Chao Yu <chao@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..cfd24a5fa271 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3664,6 +3664,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
 	if (!pin && IS_DEVICE_ALIASING(inode))
 		return -EOPNOTSUPP;
 
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
