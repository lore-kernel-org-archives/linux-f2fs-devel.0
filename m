Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42085606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dEHzrmiK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iK8VhKfi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HO+jtZmz;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw6bbrE9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=o7VWMCAoZgoYIEL2o6ga1M3iVj97Jxk13kXjhmfxfVM=; b=dEHzrmiKF+8fs4SBi5FztzEb9n
	utuS8/r15/0vGKocRzdR872Qj6APv+4n0QWaJhMDfiYWt3AbdfJ1hYeAk8P5y9rtSQLeSDQvrilPq
	cunHfYDiOWptJAPYBfvB3goALLF2re+kGq6Xm1md3e2QKoZAfVS+nEikk0S7Y6iTvxtU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNhvG-000000006pd-0w0E;
	Mon, 02 Nov 2026 02:37:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xNhuw-000000006pM-3sqi
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=; b=iK8VhKfi8g0/OLDuB9VBFyg/ZL
 FhjmeRL7nRc5tQzodEtKhvatetiZZUOhCXBJnjdT1q8C6EavtrEMVPDbNb8e9zg62rdDehjd/9YD2
 8lJ3+vhWHPL09vi4WuUDrRlgco7uL6QRtjphlQOAfkN/c0pBnU5S+Sm5nFIukafV3gW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=; b=HO+jtZmzX8+4mYsEM24bJeOshS
 N41CdUDHhAXDNf/fsHYw3dDHR1L34NprUt9MqWNGwRzW/T7JxE9qDVFnryOVXFE86wssze6afEnAg
 kmk+uUo7007ZP3qC/HjrQxx0ipiCCCq+DnNrZaPpFqu0in2GC4fLMy2HuftabKPIlFPk=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNhuw-000000007zt-1ivN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:37:02 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-89d6bd67045so1153411b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 18:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793587017; x=1794191817; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=;
 b=Dw6bbrE9JdzSR2gF32jE3EspW/fQGgV5VRjmHL4T0YFWaDDE5tlfwaz6QYzBh2Elfq
 UXrfvQc5OU9oCUdJmHQ/YbkhCBULbTCO81b4A6WD2ZIgM2C8u+YxjkQINw8kw0tzFPhh
 ITyCbbOQE6EsP9EJO7wXp9Egk+NqIviMdwaUymF2OaYuaFzPO3V3TrpDxdnyUWMQ2WIV
 IKQ2gsligGBfnKzgpVnZRCUzlACpqu98SH9Wol1cFZruBuXwp/UB5uFp8R4PIGKvxQbj
 FnryvpYK4YBa8HnDO6acNrG8OyUx8JSHaSpdqYAGy9j+MDsYoARPG7OUrbr/pdNOG/up
 dBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793587017; x=1794191817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qe3yX42ERgMuY66a5xyz0Wt6sGlKrpiqgPCE7n4UY4U=;
 b=MXWVqrIuOfZtPdhOLMBVGX8isf6IG76OoW6dBNUFlnFB347CHDGYMrQ+phSnnkeRQC
 baitw0XLmw95FYBysliUoO/LdadLyi3vas/+meYVo1YI4IURSXgqOS4UH1hMFZwj6g1f
 G237Ik2c9nUHccK+/4MVUXSp1cyYXXrHnKmGGYQ9+QBt43xNv6HZNJy2QfB37RQpGxto
 htdFCVPgJ6ZupDUOG4H3tOx7z66kWW/FIVE2r+9U9rPKaJQtQ4mKpvNOS/3CPd3ixeXp
 bRLvy6nXZkMVzYh2sGjNq7kKqgUTnNQNGllYFYDVA+SvvC5vlany1mLHgLATDemhnq+d
 JTYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkXR8AmbotFF43SkdAs8WTzIGqTPWu7QRXHR99USH9GUBVHiVXPMQ8cZfjBuWTocqs//vYOSDLSfyfK0freJEH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/okxXZF/1IYs6R+rZw3g9EFXwY+bTs0dH4rLDBE6WWhNSDIgjh
 ZcUgsfzMri87GgBcnpxjKKTBthTsDmUbvoPRty9gOeZB6IYYkK8lpcIg
X-Gm-Gg: AYBFou3BIv4lXZcPxU2UrBwUG/7vvqdV0FY7av0rn3IWFS3+1Y3V5uFwRK1szAFPZbK
 UpSAOGqsYyba0VOUe3djkkwe1I+I4TB51XHUnvm/pQiNBfnTbqDWQdlMogLahmfCY8vCQHquVmq
 kt7sL+OnqIjlMRDQWpaxEAYDTFkh/z1s13wM+qBrmb31ZJZc82hCKVcAqpSKUoaUn6hkHDXSzAl
 eaJJtal1DXlAX97FrUctlKqs2sPoOgc4thjmQBSa50BtpO1iq4Fd4nNePWG5yoD6YeInGgzXH5I
 KxaE3ruqy58ClV8jqLJ1sLeCN88tHUsY7c7uoXMrtwlETq7D1gOsvHABQtvytcVg+qe4yN4mBlW
 p4f61+JiuN90x0SDju/QsB1SfO4F774Hpt9/uC2Jkp2KWBc66w2WFMYq9WWULw6EfihqKB0UDe9
 KnhkaHQsCqoAz+qrL6s+8QD8/dEztp6jyLnby/4Nfv06vhEuPOpv/FkE7rAwdXOQkvjBTv0xlza
 EOV/LMiGTlp8mqRr1N12111MXYaUPSjVzUqs1ov3455vWq0gXiNwyusXZeo19BD2DfGQer9KBDO
 J5gr+OmB+of84Uem4gcIKK/jqnkunw8kMR9ismxNXy3Tfw==
X-Received: by 2002:a05:6a00:2e1c:b0:8a0:2d72:17c3 with SMTP id
 d2e1a72fcca58-8a9be681283mr5322129b3a.15.1793587016620; 
 Sun, 01 Nov 2026 18:36:56 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8addc705868sm167812b3a.35.2026.11.01.18.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 18:36:56 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon,  2 Nov 2026 10:36:47 +0800
Message-ID: <20261102023647.1084979-2-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
References: <20261102023647.1084979-1-zhanxusheng1024@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNhuw-000000007zt-1ivN
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: free the quota file name that
 remount drops
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

Remounting with an empty journalled quota option such as "usrjquota="
clears the name, but f2fs_apply_quota_options() overwrites the old
string without freeing it, so every such remount leaks it.

Free it after a grace period, as f2fs_show_options() may still be
reading it.

Fixes: ff11d8701b77 ("f2fs: fix to allow removing qf_name")
Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
v2: Corrected the Fixes tag (Chao), added Chao's Reviewed-by.

 fs/f2fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 510df7998c18..d86ab25fbcc5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
 	struct f2fs_fs_context *ctx = fc->fs_private;
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
-	char *qname;
+	char *qname, *old;
 	int i;
 
 	if (quota_feature)
@@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
 					GFP_KERNEL | __GFP_NOFAIL);
 			set_opt(sbi, QUOTA);
 		}
-		F2FS_OPTION(sbi).s_qf_names[i] = qname;
+		old = F2FS_OPTION(sbi).s_qf_names[i];
+		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
+		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
+		kfree_rcu_mightsleep(old);
 	}
 
 	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
