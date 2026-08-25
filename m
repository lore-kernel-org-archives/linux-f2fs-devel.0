Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F59FC5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p9evwdMz6oawQziTkD4wZIT3tZ9K9uZJg8wcK9m0BNk=; b=NqY/anRFmIhE85zCAks8U3C6Ak
	EQ+vD18mQ5q/DyxqL75WLZgbf1XZtKN8BK90MDeBdo4R0FFAj1+H/seWscM/BhMVJJI7w552Kd2zH
	XPnpcRhbEZsCd7tuDh+aHm650gTjDvEAqi5kcxYX1LdgT4pTxXcdLEJe5cy8niekJhZM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyjwS-0001mH-B7;
	Tue, 25 Aug 2026 05:43:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyjwQ-0001mA-TL
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sQIZQtZTZmVKtiuRC97aAVktWwFVwlmf6j6WdA+W4Ds=; b=VSS/9YB01lyREIPFzlc+Fi8oOd
 qpyW5aeoz+IoOc9TuDLrRajy65R3ytQlGW4pAP5VFOCp61J6A7gNQS2zTA9bHB78AR47D3xiu3CLR
 qnJXTCC/Fvr5ilzGtFK/9TQ++bmAOdU+IFOFtDPr8Tw2yAckZJ9eqfHaTUiOe0gKN0I8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sQIZQtZTZmVKtiuRC97aAVktWwFVwlmf6j6WdA+W4Ds=; b=ZM2ccsk0TZFaUBLAyTAkiqkkwv
 ij0oQEm4j+QIONNYQHkUoBlJK1R+0XmbNmi4ByU3whszn8x0Lszm0H5UzC6rCgAxvLtPfbnLNIeAr
 bWWBVRY3ucWwUbRTYzVy7q2bACG19WD2+sLz7rqyf77R1jWM0dWaF3O5oGQBEbP9CSZM=;
Received: from mail-pl1-f171.google.com ([209.85.214.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyjwQ-00036M-AH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 05:43:23 +0000
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so52344875ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 22:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787636596; x=1788241396; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sQIZQtZTZmVKtiuRC97aAVktWwFVwlmf6j6WdA+W4Ds=;
 b=qhasJMqycc2A7YvPc2C3kLhnV3/bDeZ7mYBK60u7d4wV7FYuMR91Rjxis/15Nt/mUf
 9R8oCVFl43wss7j/U1YhLLGvnBgkOkV3XvDFU7dIfIJPBofuRzov2ACRQ/tYZ3+1B8jm
 8uUV6sJwaYqG9uk2wEJMW3+E0fLfqkX8C98BicMH/F+rHUkh62VUd5p2HjaJj40uoIdy
 Egc5qmqFU1Pk40Zikl3OVh4p+p0l3fZjOrfiSgxbwvJQaGVhPxVgOr/OiGGSwmFRU4dU
 BUSfIn3sfPVBqE5MFJYbHOYMA8CeoHxIVYEP3VC+0kC89ab14HV7gEdKGzejBwWUklF9
 cYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787636596; x=1788241396;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sQIZQtZTZmVKtiuRC97aAVktWwFVwlmf6j6WdA+W4Ds=;
 b=Y1m459UAXmkiE7JC5OQiBLyTDMx1RY2VAv61pc/9aaAhA+ypSasaP1oPvkKS9VXqGz
 YUc+MuPcjywVt5OZbWgsuYk++354Bn4AzFBeKB5CgpP6IqbevhGPOXK2X1LS4k9HcXX0
 IsDVGIyl8KhuROhw716UJBsxiQjJH7gdPvbfrwIfilsaniA+OudNuhPbxk4d6K1EeXQ3
 GN9Ee3+mq1Uuq7PGA4WkDi20DSC4BBVVT+DcqStRFA9VJewVyZGIdiiDjDXPhpgj1hOh
 8Rrt/EmY15dymvoirlhZ6+f1WYb9GJfolJQ4FOhj5lDyoJlkayDBu7mMzdPFlAzt+1GD
 L5pQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RowSBFdUqteugBeAEmkBIqS3QLhUykXNDkQXKv5mwnNCpkvgUb3Jy4c2l30z0bTtBPAFrpwujOWLbEDDSSYt6/B@lists.sourceforge.net
X-Gm-Message-State: AFuF++k4ZSGGVlmhXNv2XL18qemD86Pdfco+KbpL9o9ixmMYbZcYo6jz
 duRedqEn8PReQAweO/tdXBfw+uq4hDP8XYhx/PUFjO0bOwA1Q163uVrB
X-Gm-Gg: AR+sD10qj1DimmU60jHH5mg+PeiAZofjkUKpYMEtAhjegqoZ69djFLX+x/E93TowEZb
 M7IjBnL3xAMwkRKoqYX/AbUwkm+BIGByO2/tvw0qZlQpBIHJDneKMvlrfw+c3fWXQeLHuDoerqr
 a2NEADPH2HfGPW8LUstJlG6sTNT75pcSxXbY9lDzD3zjMQIz0A1Cs+gkHcmsDJnL5GMT07wpoVy
 OYbcxBSkah/JuM8uolGXyFxmlncgIDU1b8xg2whTPDKl3RWbpFbz1FuSIXo7utdzb52xhDWuQEH
 oITA8PNSDwTlx9Is7j2UW7h2rh9tGJ9nf57D9pDIE1kYN14AuV9BA6RiEKq2Mx2pYc3VWx+7ibt
 EguXqqe+tOi2gCM1F4cbGY+Fso2Fh8N3vuRhLnfsaWrws6fgJrkLaQ/voJ9ZHTRdX+6NiR3I/CX
 2/scD+lDBWQBSuyS89BialDLQCQLYcpRKR5gagD4pFfNSL+CjQF1bBgS7DwkoYAw3V042SBU7Hm
 RHMKq6xTFLmIPmxpv8UsqDf
X-Received: by 2002:a17:902:cccc:b0:2ce:93a3:c168 with SMTP id
 d9443c01a7336-2d6dcb5e34dmr79955915ad.7.1787636596570; 
 Mon, 24 Aug 2026 22:43:16 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d6768e8907sm24353845ad.78.2026.08.24.22.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:43:15 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Tue, 25 Aug 2026 13:43:09 +0800
Message-ID: <20260825054309.400026-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824134731.3704352-8-chao@kernel.org>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-8-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wyjwQ-00036M-AH
Subject: Re: [f2fs-dev] [PATCH v2 07/12] f2fs: cache: use node cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> entry = xa_load(&META_CACHE(sbi)->root, nid);
> if (entry)
> 	return;
>
> entry = f2fs_grab_node_cache(sbi, nid);

The first lookup uses `nid` against `META_CACHE`, whose keys are physical
block addresses, while the subsequent cache operation uses the NID-keyed node
cache.

Is the lookup here intended to test the PBA-keyed meta cache or the NID-keyed
node cache?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
