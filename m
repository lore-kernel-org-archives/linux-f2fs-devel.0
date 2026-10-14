Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3E5CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0v5FwvYRJPxpqq3l2jj8Q45fk0I1nKCSEnrfRcG8CXk=; b=gwZ05LHF8aMHpNcEaYkuijiiFO
	Cw5ddlYhkWV7Vhn1DkUcRoYk0ok7RRVU1wxjInIW6HdCPtGEfyABrmP7dkmErBWHXjWVOonnGiGs0
	Rq7XnP2CgrDG/Y2yZD5KFlWPl/hxKhAXOgk5lP7YKg2VJuq1IB4NHwCFVlhFbXmgcL9s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1gj-0004DM-VM;
	Wed, 14 Oct 2026 16:18:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xH1gj-0004DG-4y
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2g7FKye6udApPbn5qhD4eU93zmwJR2p8WwqGCl3cSNY=; b=TGoZIMt/xqaNaZTrS/Sv9iTYfA
 /AsmHV2MEbVv50+Cn7I6gw1Vd2eiOgYtWxa+oMHjiXKoQxYfw01y+L/6oQ5VLNb7h1Z/RAq2464oo
 zUffax8HLSHzJaVrzqznHS6z9UEJvLcUstW91pfnkb9bVDQvrN6cEmRHwf+IVjb8W4Jk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2g7FKye6udApPbn5qhD4eU93zmwJR2p8WwqGCl3cSNY=; b=dJJIyb2fo3Hka0znQHh9mSVqzn
 WTeT+4YGx5rdB8qvVd8bQQZ1VcUPA8s94o6ipHToc66Jpe2NLUytWA7KjIij5gbwG3Y8JjdvNXOGK
 Cbi2feMXh5Z336NSeuryi0njkTQ+wzmko1JcLBiSaZiYojNVw7lQX4bdc+OThLb59pO0=;
Received: from mail-pz2-f5.google.com ([74.125.228.5])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH1gf-0006bz-52 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:18:42 +0000
Received: by mail-pz2-f5.google.com with SMTP id
 41be03b00d2f7-cc7c286026aso568897a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994715; x=1792599515; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2g7FKye6udApPbn5qhD4eU93zmwJR2p8WwqGCl3cSNY=;
 b=Nzztr9FOsRuT8xhNd20fA6mUZvVGFVXZJ/tZZVWYmcxZPjXCwo+cDsMAmBfAKsjAcR
 0VMxjk2cVXDKEQMb71e/5wvm7ZufyEWO5DcRcO32TEWKncg/iJ/wjuQI95vSjXOpe057
 noB3jG+7V6olJonuhwCpVbbD/z/JqqNrEeGhdBQbFdWCzrSDXUzx2vw4d9bP60A9a9yl
 GqtGt/z9yiwndiUeZfrM1wGavJplk4OzrMfG6yzEEGUkzl1Dhb494pWI+9P+rJPhzhnN
 PtdAaJ905X4DLSvozgxL+GFyagQrnEszz/etH9+BtZfrv+l4mfA39+3mOLjaIfm0yaSc
 BNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994715; x=1792599515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2g7FKye6udApPbn5qhD4eU93zmwJR2p8WwqGCl3cSNY=;
 b=o0EgK/YXl5aVHZ3ZWZGY2C9yEvJeeSOEcldz5izZChpFAhtg94uK5O5/87I0hscgE8
 j0an1Klyvt1FXhjE02/PfjeB87iJUKpD2z5A53iMizu3VXCEDehOIH89lF33kj2vjF7P
 Bys9niUhNWLs6Q+nxxT9MGOJL4K4o3Rti+FFJB9hZIa1v+ogsDGtjmgZmahntR97/LXv
 /mujUo0Ck9m5oQN/tk9Ik0NPFtXyPVUXmHVYFO48V7qpoydf+PaMcNgKqaLVqcv7IMzJ
 Pp1bsOl7RLR8cMm+a9Ea/+zBk+1rCmRzJVk1GWAafKWcc39GkBF6XP8iH6yPSBophIyb
 cnAg==
X-Gm-Message-State: AFq9FYKcuftkA6Zo3cIT/y0s4GVhZD1l1vWGd6swQcy5jb8DdvGcGlLE
 PYTk5fyVxuwWvhQQoKs2aY4nxI30kKEQRrrwMIixqndOf1wkxzvG5JhffbgelwCtzAA=
X-Gm-Gg: AYBFou28/+67KFfsvTa8Kf6tBuIVgjj6Y0XrbzUVa74BTbgyhsEBfzBnkgajSEgpg0M
 kZhDjv48cG03cWCMaaDJ4Uyj1aslIwBD/U7YTedqbXAe3kzXkdtG/bPem9Qgel+BMYS5XIhaNVr
 G+UrsMcdA9qRr7MuJhJqzLGTteVcXlBdwuhubN7ITH1J0gTrYXf548cXizeFDYlYuOW/1hrtd0/
 /pC0kquqZNgAOirzWeawa7RRJkd6lTH1nbFH2yiZYBheuOs3cYEfIFt2H10B4HZJBVdOl+q36wr
 3XL98vMp4lCjC9xtnhntZybBSNXPDK1uR9IpYNCIMpGe8fF7wYzVKEc13HCgoC9Jky4qPGychc8
 vWMZuiIvdHc36EOEKG4j19jCZ/XdsV9LklCUr9BqtTwwFt2dN5cLqoxUFW7gNPIjMZFzynVO3uq
 AEREEhCNFlDoXk8/dnipGarAkuLiYg9w3cUrJvccKdcxNUifiaUm7K1/VVtFDRTANrVO97C2BSP
 GI1JMs9WIGuh8hx3lH07aZHRq731xjSoEGG
X-Received: by 2002:a05:6a00:3d53:b0:874:708d:b63a with SMTP id
 d2e1a72fcca58-897c76e242bmr14909641b3a.27.1791994715346; 
 Wed, 14 Oct 2026 09:18:35 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d7f51fce9sm1364168b3a.8.2026.10.14.09.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:18:34 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 00:18:27 +0800
Message-ID: <20261014161831.3831197-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-3-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-3-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xH1gf-0006bz-52
Subject: Re: [f2fs-dev] [PATCH v5 02/16] f2fs: carry subpage offset and
 count in write IO
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko says:
> The accounting size uses the full folio size instead of the newly computed bio_len
> for partial large folio writes, causing cgroup over-accounting.

Changes:
@@ -1111,7 +1122,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc)
-		wbc_account_cgroup_owner(fio->io_wbc, folio, folio_size(folio));
+		wbc_account_cgroup_owner(fio->io_wbc, folio, bio_len);
 
 	inc_cache_count(fio->sbi, WB_DATA_TYPE(folio, false));
 

v4 passed the whole folio size to wbc_account_cgroup_owner().
v5 fixes this by using bio_len.

Sashiko: https://sashiko.dev/#/patchset/20261013115621.968742-1-nzzhao.sigma%40gmail.com

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
