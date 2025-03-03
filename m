Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2649C282D2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:22:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tp9UQ-0004Fr-In;
	Mon, 03 Mar 2025 17:22:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sandeen@redhat.com>) id 1tp9UP-0004Fk-TX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Mar 2025 17:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=content-type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HNtb0WzQQqVfRRT8LeO2w0dai1vRf4isndM0H68L+7U=; b=k0XLmCkwsEkl1zGjoz9xF6e5c/
 lv12LY6USwfQa3INDFkCot4H5UPZf9I+36ggQPBuHFGN+G3Q3UUDxybg+iFBk5E/7oAsn5EsSLegD
 JXKAxiVtEqUWwRFIgQbf/aGUfcniIrIJ7rl7vJK3mFvsnc8DhH8a0DF+ea1Do7r7R37g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=content-type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HNtb0WzQQqVfRRT8LeO2w0dai1vRf4isndM0H68L+7U=; b=c/ISzsl7XXD+wi6LCs72S+ch1m
 eLwf4ou1FI/hSoowAH7k4As1lpRVZrF6IVCy3bWMjXHz3AYX57uPwp2QLkVrxTe1BO2uyqETw9qzu
 75BTmr5tQoPHEpPRGMXN7y49ouCTSRcNk6TydXWrCXeffqY1jwy/HcHuch82xiISpdJQ=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tp9UF-0008QW-5K for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Mar 2025 17:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741022500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNtb0WzQQqVfRRT8LeO2w0dai1vRf4isndM0H68L+7U=;
 b=XbFDBwl3d/31NZ8gIwEsQecXu+x8eMoTVmyrbfR9ZiHH8WB4JywANaOmppWoChvEBVPjJZ
 PMplJbcKqet9VVT1suLEpMNz71mtX+TNuiKuLlG/JqdfcaSxUo/dw9cHEzHBvUrNqfjLbV
 4zdu8r8efQRse0Y2ixbZIXWMRCqoxvM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-76itFTxqN9CnjR-wqn68uA-1; Mon, 03 Mar 2025 12:21:33 -0500
X-MC-Unique: 76itFTxqN9CnjR-wqn68uA-1
X-Mimecast-MFC-AGG-ID: 76itFTxqN9CnjR-wqn68uA_1741022493
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85ae1c53d9fso61778439f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Mar 2025 09:21:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741022492; x=1741627292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNtb0WzQQqVfRRT8LeO2w0dai1vRf4isndM0H68L+7U=;
 b=sslQ1gnh+0Zp1jqYHwlNfpCPh9Exblrd3zkLgwPhLKy9apHJqSE/Dg1ecI1po3TKzX
 6QxMTexpfn7dxrE5t7xsP8Sw5bsXLFnJFsI2rpo8+oNZMVBBz0fA+xyJduUokyNZfbvO
 ZMh/JYOtqwNx0r9UzizQZTvPUC+owwiB4Az4DYwpU4WkkO8C4sTIy0y3wyC3OoPZ0FJt
 HwVrEjpi6zr1k0usV8GdgqFtgGghpKClxKplgvyBBUwIaZwbdXp/9rj1sMd7rO6kuRqH
 ep0d2a8kxoUxWYyz65vwOZ1t/EpwHlIusv1OHbkIbZdxZfV7eDZk0Vz7JjgE3tnVvRN5
 IdlA==
X-Gm-Message-State: AOJu0YyBK5KDV6E34xPXh6czPulmW5blmxKJt0rTldCPS8Vd0pm1ziQt
 rMmSgk0LKdjpqg5tF1V4CLQ6s3R4vYZgJQ0syGjUfFpcKfY1dekInsXEK+LurALcLgyqWEtLjdp
 sUj3l8/Q4wzcyrRdsgYuduqvcjmNshCEIwV5+Env12WozxmKU13+f4f0EQ1hHowGocrwFTFcWc8
 DIlsJY9332+DYfN5v87uol9LBx5hbX39E+dWfGogA2DE67MLddR18GQsIp0g==
X-Gm-Gg: ASbGncvk5dyIF8Vqy0cJavapzrZQky64tqEIUCYhZCvZ1jVM/ZoGWyQG+uZgf3DrsA0
 0pjjRxXO8sCcjH4Hx04i1EvN42Q8UDtNYU9xYjOeNxaVdSmkHOA5aqlNhBT5XkTmYGSHoYfxDoW
 2UtR6VZ4lNI2IaRkzv7yFryBtgbS1S04a0y3biAgEUa0mp+ooqWoy8KqEEY0nz0wsCQsLpk58xl
 Ihf66Q3KbzpLH5zVblzvUC9TqfISWuqMX0R5VWp5efCWW4uk1MWO8mM5LEcRf5Qjq4uaP1yfSUF
 lNADJtTBp87YaPpRdqh7F/EYdsozxWE=
X-Received: by 2002:a05:6602:3d2:b0:855:c476:8b97 with SMTP id
 ca18e2360f4ac-85881f33220mr1485014839f.8.1741022492455; 
 Mon, 03 Mar 2025 09:21:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIqoYIsFI9g8LJvmlMWS9DAajpDgeNl7wWzqTZed7/KB7vi5InR7IRviL6Qny+wybYiL4zlQ==
X-Received: by 2002:a05:6602:3d2:b0:855:c476:8b97 with SMTP id
 ca18e2360f4ac-85881f33220mr1485012239f.8.1741022492045; 
 Mon, 03 Mar 2025 09:21:32 -0800 (PST)
Received: from fedora-rawhide.sandeen.net ([65.128.97.82])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85add261b4csm49563939f.9.2025.03.03.09.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:21:31 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  3 Mar 2025 11:12:12 -0600
Message-ID: <20250303172127.298602-3-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250303172127.298602-1-sandeen@redhat.com>
References: <20250303172127.298602-1-sandeen@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k2TI-EjBfrnmZUUacZqnND5cCqf7fUIJJXaoU4zjo8E_1741022493
X-Mimecast-Originator: redhat.com
X-Headers-End: 1tp9UF-0008QW-5K
Subject: [f2fs-dev] [PATCH 2/9] f2fs: consolidate unsupported option
 handling errors
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
Cc: jaegeuk@kernel.org, lihongbo22@huawei.com,
 Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When certain build-time options are disabled, some mount options are not
accepted. For quota and compression, all related options are dismissed
with a single error message. For xattr, acl, and fault injection, each
option is handled individually. In addition, inline_xattr_size was missed
when CONFIG_F2FS_FS_XATTR was disabled.

Collapse xattr, acl, and fault injection errors into a single string, for
simplicity, and handle the missing inline_xattr_size case.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/f2fs/super.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dd35d199775a..29b3aa1ee99c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -772,16 +772,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			break;
 #else
 		case Opt_user_xattr:
-			f2fs_info(sbi, "user_xattr options not supported");
-			break;
 		case Opt_nouser_xattr:
-			f2fs_info(sbi, "nouser_xattr options not supported");
-			break;
 		case Opt_inline_xattr:
-			f2fs_info(sbi, "inline_xattr options not supported");
-			break;
 		case Opt_noinline_xattr:
-			f2fs_info(sbi, "noinline_xattr options not supported");
+		case Opt_inline_xattr_size:
+			f2fs_info(sbi, "xattr options not supported");
 			break;
 #endif
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
@@ -793,10 +788,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			break;
 #else
 		case Opt_acl:
-			f2fs_info(sbi, "acl options not supported");
-			break;
 		case Opt_noacl:
-			f2fs_info(sbi, "noacl options not supported");
+			f2fs_info(sbi, "acl options not supported");
 			break;
 #endif
 		case Opt_active_logs:
@@ -919,11 +912,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			break;
 #else
 		case Opt_fault_injection:
-			f2fs_info(sbi, "fault_injection options not supported");
-			break;
-
 		case Opt_fault_type:
-			f2fs_info(sbi, "fault_type options not supported");
+			f2fs_info(sbi, "fault injection options not supported");
 			break;
 #endif
 		case Opt_lazytime:
-- 
2.48.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
