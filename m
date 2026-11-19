Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8BA606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G2vhKWmF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YTqkDVxf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gu1vwbZN;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NDcPec/8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3AB0WfcJIpsjdtp/S4SGm/h0x0ArLpLyEMePcZCc7ew=; b=G2vhKWmFHjJ8a5MqKe0a2KkkQ9
	8V8ssztF2rkM4+HIQvIfRoQobHCnwr5lfD6TJPky3GmTsTQuvwWtYCgotJCUzWKHUwkpimqcQ1fOQ
	VZ+d5GYVZMwyjISALg+gziG1X6rwN3aXhnjDrWr0zvGvuLShefodhFLLJokU/lg8YPxk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUAPh-000000006q5-1mLE;
	Thu, 19 Nov 2026 22:15:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3Bm__ag4KAEEvduwkdnnxnuhwljrrjoh.frp@flex--sarthakkukreti.bounces.google.com>)
 id 1xUAPg-000000006py-0ZKl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 22:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=; b=Y
 TqkDVxfWWFRbu8IKnH7B90SwaEeRMoSjSZkPMOdxxu65UBN+VigNSW1syi209p+4CVAVL2YPCwcZ3
 25+xDBed/eHPWlfyfvQXJ7Z6q8UeU5Q9IdU7S8nIG7RR7oQpCyK4RCDA0H8x0ECpqvbqQuqjNDpoq
 L5ju9GPsCl28foq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=; b=gu1vwbZNuKhCnwLyt63MCzRgGl
 jg+32Hr/hUKRb4RHN1oheEgaDre2+kBmQ2fGmNvh0xGYLRgOOF3KLZ0QXJTWw5KKf/IJKaBkX/3ko
 T6T/sOKkNiPvc9R5f6MN31jea6WhA2DemudmyfPsB4yRN3sW6pk6h+MOT7amXTkU9Qcs=;
Received: from mail-pl1-f200.google.com ([209.85.214.200])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUAPf-0000000053y-1IGZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 22:15:28 +0000
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ed1fbae872so2548015ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795126522; x=1795731322;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=;
 b=NDcPec/8PrPAFGm2tAFZqXTNnuX6J/baUz7TSqPBjEWM/tUhtPlwaNrPyZJA6Waaz2
 gWYn9egvQLd+xAXizIZWnvVBkBykhoH78rt6tKW/JrekcTUKzudBGkJvl+W4SDZjUoa/
 48AljayvDbwWU+XWsZDMsxd3gwBW3uJruhRL5iE3Lv4w+NQEe+du+Q9jnzLNhJxqE/a/
 JTgDhUH9X84PQtUP04a666MA8H5ohywL0RY3pTqryRn5fzlQmqJJmqOoK1/GtyBMArfl
 YokZCeY8aY4aT6BbXGq0J5MEy3jHB8b8e+KI8HpTtI3DQ6Rn4jaaOcqdSx49DvnS2P5A
 lSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795126522; x=1795731322;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=;
 b=Pq5UspYaQ+b32I0vtxVtz4ps18TeSbUF/zJIgsatrWudeNjYxnqSi4UvIG74fS8VyU
 2k1y0PYmy+0rQtA5qAfNOa5WYddj8SRbh1GzRkKjk/bH8JnUPswpxGfHePfg8QBaPbL1
 X9BgKHzuAFeGE1qr0yadqxc/bH60rqd8mjeY7B1A9BvF4HMJSJyZomhnECEDSSBC0Ku7
 qn7Cbnkk4d4HthurThD0+Ar2a9+7mcrDc1iql6Bha0IMrfSZYl4CzPXlkdV7tFHR8f8d
 VI1wEpQXa7CICIRTyaFcldXYftthLg9dLn1kQ6bA2GVtCKRjOPqldLNM3wRegln8g260
 uGUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFtUk9FhxN4kXokcttHUbmQZa+cvr+noN0xtqpvWu1UeSeixh4kKxC9k0dosLp5eL6sA11xt/smHcqNV4949Ake@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8lNs+fE7KAMuqRTfw1WoWiEQ27fhuMLCmUPDSPuPrJJx+4BASs
 wy6podKh1v6BIFCHjcV0RmuwE0UwqZhz7+Kd8b0Mq/a0YNiUEo5V6FkQ27sfzjA2Z9CMkvsVq4g
 vdlkGEaYZzn0c4PLvpP9YdVJBOnSZUaZjHmGonQ==
X-Received: from dlam10.prod.google.com ([2002:a05:701b:208a:b0:1b5:55a9:d18a])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:42d4:20b0:1b5:43d8:b82a with SMTP id
 a92af1059eb24-1b55689e7b7mr849071c88.9.1795124998470; 
 Thu, 19 Nov 2026 13:49:58 -0800 (PST)
Date: Thu, 19 Nov 2026 13:49:44 -0800
In-Reply-To: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119214944.1480596-4-sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, 
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xUAPf-0000000053y-1IGZ
Subject: [f2fs-dev] [PATCH v2 3/3] f2fs: reject casefolded names that fold
 to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sarthak Kukreti <sarthakkukreti@google.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
 Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dmitry Torokhov <dtor@google.com>

Filenames consisting only of ignorable Unicode characters fold to empty
strings, and names with leading dots and ignorable characters can fold
to "." or "..". Allowing such names in casefolded directories can corrupt
directory structure or cause confusion with special entries.

Reject any non-dot names that fold to empty, ".", or ".." during
casefolded name setup, while still allowing invalid UTF-8 sequences to
be handled as opaque byte sequences when strict mode is not enabled.

Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/f2fs/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 97f7fef6b068..f1d40f818b35 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -77,13 +77,17 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 
 		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
 				    buf, F2FS_NAME_LEN);
-		if (len <= 0) {
+		if (len < 0) {
 			kmem_cache_free(f2fs_cf_name_slab, buf);
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 			return 0;
 		}
+		if (len == 0 || name_is_dot_dotdot(buf, len)) {
+			kmem_cache_free(f2fs_cf_name_slab, buf);
+			return -EINVAL;
+		}
 		fname->cf_name.name = buf;
 		fname->cf_name.len = len;
 	}
-- 
2.56.1.750.gf70dc682cf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
