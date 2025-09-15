Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816E8CAC597
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YcXP4Dz60JLEK1jjq9BrE721gzs08Pco/2sP0klhZQ8=; b=D4yZV3TpaB2QR9mNzu8OxlrZuv
	90fiWf8VqwheUVYwuahh2LQrc4FDxE3+ve7z+K5OGhLc94J1wNB0ic7NNbGhaPnnEvkkZLt8SFoyN
	1E8oOdEzqdmZTjedhCS+7EHqIsvGjpTPyr0Swu4IA052gF6L4l0q+iI5geyelp3+y7oU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uy6Zl-0008Cn-Ga;
	Mon, 15 Sep 2025 10:36:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3zeTHaAwKAAQntvyweos0womksskpi.gsq@flex--jprusakowski.bounces.google.com>)
 id 1uy6Zk-0008Cd-Hk for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 10:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RhOb+fXoz/JynstoF4uW9k/iZuOaeZSzWY+DYBWeboA=; b=DftS1XbhG+uqW+aGu2eOXcrSem
 APeAjvb7+kX6JOd/X4varAl4kB8GnFTyeOdWjzc0Gw9pcjcExnZeF4eOXGPPWpA7ojZwORp2aMDuj
 KywKfZUA/+CAk9+IjQ1+Pqp5igTXXVyM0i11UNxvQ0NqCunfy1U4cBvFqbMgFs9yubZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RhOb+fXoz/JynstoF4uW9k/iZuOaeZSzWY+DYBWeboA=; b=fFMVsBwVSSXEVBlAkScD3XwQ8r
 XzOosyUm06eiWHuaLWRQy8KxS+cEOgsWMk0bM9eASn/v/wb4SaJBOnfyRPhlrq4+1d7gmBiFncv7C
 SngcnFdJL4axzn2ocBccEcMD/I1zJES61fB4CgIUza1ML2OXC+138ARybyklW+zTy1Qc=;
Received: from mail-ej1-f74.google.com ([209.85.218.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uy6Zl-0000R2-07 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 10:36:49 +0000
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-b078ab1c992so491360766b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Sep 2025 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757932597; x=1758537397;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RhOb+fXoz/JynstoF4uW9k/iZuOaeZSzWY+DYBWeboA=;
 b=EBlWihLB144ypqyZE6mgbWDikmINXO8/+/YKrKm5egPoKWQ0SxQ75m87nTx1SROkST
 arPsbNkYKjBiCExrjh451cEpAPa0jAKsKVkcAmRJA6lVi48dHI1gIslr00I7oyPJ/ssS
 uvcXu23Z/4Cgp5djlaqzPsCDOJYe0o1gH0h0l1x1xEYIL/PZjFNEJ6pn0nvp4kVtSxve
 MLe/ahd6fqvTIykKNLzQL6vUXNrtHX5PkoZoDbG3v87rBjRCRPhk9KwYeQyArAt2xO7P
 R04lHsp2RzU6zZYw/VR6GwDg9PISXgEViTKPbBvFYXMRiYzyqu1C6hrWNgQZ4kcFSxwz
 Hk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757932597; x=1758537397;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RhOb+fXoz/JynstoF4uW9k/iZuOaeZSzWY+DYBWeboA=;
 b=hDUjj719qHHKrkru9IPfcHlfyqSHJCWjtqrB2h3pxdBs2qVqpfu/pasaUQ9hHJe5HN
 q6BsdSv72FTYPlmZWvSNv+DOiHDelEuqOOycLM3xH1DoDNsp87YvyPepcHy5TOeDpj2+
 ysWNAT0YwwH84BFuIHRDGHECl8fLS872Axh2AYLsoQOgOO+ZYe4ByINbdaqIFUmmBw8K
 Ux+4a+xncY3A5KTgSsZIBE0B8bMwUom8NlKuybK3YAet5xyk+5LksD8QEU9shxdY/+cw
 XkVwaTgC0z+eHo+UjDH1AUoTDS3YFCGxAsvPtc0GJgWz29b2uAd3efWgPix41KYVr7J7
 MqmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUweN2vus7DkdSKXjQEWFQC4/+IxHm7VNA8YfacS/MDu6iUKuOr2xaEzk5l0wjxCAN0rKGQIuGDlj8NaZ8fyXRr@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyNzrt9UQpzn9sEcRku7f16rilL/V/HOT8RPbuJDjOh1ool/VaI
 IlAzvHO2vVhg7vTCnYnEA+7JyL5CsHqG/gMfYpg1V3eYPBR1Cq30JX9KXAe9Zjca/pibQHjHoqs
 RdRdVi4xbRIcSnSrItGX9VWFRQyuRbg==
X-Google-Smtp-Source: AGHT+IEJoLywW7u172IwfK9/WZbn/vWDjB5heLqpeIZl1R5HWLwd/Sp6g2o2dBQVVVgodrM3OmdmACuDrPXNTYNgOsU=
X-Received: from ejdcw6.prod.google.com ([2002:a17:907:1606:b0:b07:e174:152a])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7b8d:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b07c3540759mr1152316466b.13.1757930701187; 
 Mon, 15 Sep 2025 03:05:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:04:51 +0200
In-Reply-To: <20250915100451.810719-1-jprusakowski@google.com>
Mime-Version: 1.0
References: <20250915100451.810719-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915100451.810719-2-jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
 fstests@vger.kernel.org
X-Headers-End: 1uy6Zl-0000R2-07
Subject: [f2fs-dev] [PATCH v2 1/1] common/encrypt: Do not run
 _verify_ciphertext_for_encryption_policy on compressed FS
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: jaegeuk@kernel.org, Eric Biggers <ebiggers@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

verify_ciphertext_for_encryption_policy() checks if encryption works
correctly by reading encrypted file's contents directly from a block device and
comparing it to a known good ciphertext.

This, however, won't work if the test file is also compressed. So this patch
adds a check if a test file is compressed and disables compression in this case.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 common/encrypt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index d4f6e3dc..c25ff5a4 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
 	_set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
 	for src in $tmp.testfile_*; do
 		dst=$dir/${src##*.}
+		# To make sure the test file is not compressed we create an empty one
+		# and disable compression first (F2FS won't allow resetting the
+		# compression flag if the file has data already in it).
+		touch $dst
+		if lsattr $dst | grep -qE ".+c.+ $dst" ; then
+			chattr -c $dst
+		fi
 		cp $src $dst
 		inode=$(stat -c %i $dst)
 		blocklist=$(_get_ciphertext_block_list $dst)
-- 
2.51.0.384.g4c02a37b29-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
