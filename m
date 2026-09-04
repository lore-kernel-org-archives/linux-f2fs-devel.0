Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F936C79F80
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+VDR9NBVk6un3Z7ovoH/Q7Q+1zqzaRRdlEOv7G1AIU=; b=Ja8DwRoXTARIVeycXM40FNck5Y
	xahhQ7kxAhSZ9OiUwAciPZR0c9ERM2Dgwu7oGqpnKO4/Q78e0m3h4oKyrcaGIWmURyi6tGR8wUgw9
	3xHKXVXt6YRdxEWjh/sZnrOP2+iINJkcuDOEL9iueUAfTX7MA6nzg0wWvxePvNkFp/iU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2MFD-0007qm-I1;
	Fri, 04 Sep 2026 05:13:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x2MFC-0007qb-NJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 05:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=mzu2t5xVbKlHbo/kDmPdH5ZGGW
 5q1CngJAaLJ9sJO5UUbhRTCmp8szStCThSNPgNLHzb+r7dc6SPHrJH0wYK3QcmTusRNTRoeOdSuZM
 Oknue8cMnRDtaDgc+v90wN/zyFMzKc5uNbnEEZL/L62Gywzb8xHdu5cHV/cIJ2d7wk2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=G2V5yUIA2nsvk6fqbmtC8EXW7u
 yZIfnmH87K6ljLQpeOtvAnVqMKXfH6+J3qNy7CpOPDC/wZI+MB5/nHaaed0BYaZlZT+ikOer1UPdh
 mBsbCoSiT65IrrXC2QLGcg1PSODhWzbq783VGotfMy+Xs4FueQBTq91cq0jgREF/C9+E=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2MFD-00007a-3K for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 05:13:43 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-848643382fcso624098b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 22:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788498817; x=1789103617; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=aGpg0Lfpx7wzb1OglDkmpLZ2n3gsaN+5F96a/2G/eJzJ+sTlDgdorugPz1zC5f+5h/
 zNhVnmG/NX9kohk/6bhqLChdAZNmHdnEChbkmskwiUP1Fr2K+5UtSnJQAP8edk8zYZ6m
 2icOEi/yWlSDUP3i6euipyWXQ8fZS9h3PFM48MNkSQLctTN17HrcKg1QOViSp+0vdL0d
 JI8kkbSacraczr1JBz7m3ArKXqBgwz0Aygwr+D8XynQWiLXOKVrcypRFF7lpJw9H0Psf
 1iLcOnrZA3E9gDbq0Eh4N/BWsAEpG8Pk60CC92h65lwE17VU+VAMeuQA0s8xkpV7qO2S
 xpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788498817; x=1789103617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=pzUm4Tf7Y8Jpr8+uSKrs6IqzZbse51/Q/Ae90asZ7GspdcZpaiUxeYCob3dajGYQCW
 fH/PosUzX4pWCo0B26Gy6wupId+gG7gDwAsY1dFS7/chBh8yoh/V7DGAAQwv9esniF5Z
 WoSbHf6vo7iNRB2wxwMz60HjecqA9BrVY79rp0LIPY00ZITRdV+9dOrlWxEvEhsS2W2A
 OtNJCUMjfk0Kz4vgvqE96Dk1IGzpsr+rqyTl65jiN29N1JuUyThUeqANyOtLTnmp0aTT
 23zY0eGZPJ5ecIFeBz7rt+IYnGcLqL1sQ/Kb0Cjvqh81i4rguBmpD5/DGXfbyEKm4Soy
 jvFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4IMMT3E/hCic1coseWIvoFlOSubS61OPGajWO3axm5dBidcVRfSUzzJIpJp1FMZfbvrAN/tv+cFzsiuwvcbxS@lists.sourceforge.net
X-Gm-Message-State: AFuF++nC5SDXGBaxSTuKHtf1d1jlAV5IFOa0Zu4ybmlaOOgDwkq5jjQR
 xTEodv0GTRDbDrcZTFWNv5xxyDzR0xfV4pcVBtwnvtmKrhUUsWwwi4+i
X-Gm-Gg: AYBFou1tnW9L5YfHF92yLlHeFRiCNLqGobLZ3dQweeHezxWgEKHEjq3DtWQHQ36nk75
 k4bZZLHoo8RtoiL3FKK0Oksa9AR++BkPhiDr34e+4dBXAHxE3l4Bhl0Lql2AahL+H5bTpxssMAO
 c9bO0d3up70L3o+VFB7UL7tAIpuopk8S/xYMtRvgLReSsx5N6cKJZw5i2Xbb8SPnyy7HSktYGnM
 aelig3ogxMLtjmssHZv2fVmRX/mwHmDJBlk/U2KFWhnW3+SoWw140fYwlAPBYt8RAcZWEVNiGc0
 T6t0Kh7+nLafW53rjjvl4NxFzgL2N6ixceauRyaxzgEsfZ/WU9vKKUN3aJya9Xr/c8YQ2oZ1w6A
 5xExMrsr83VhpMuc9l73SHpDF2+3nfMV9mU6WZpLX8aGJG7KwBgly7fFraanbIqKhx/f2ZKLxuP
 iDVl6oLDlpVQWo0NkAt0SmERshhr1jfCixbTRE2qv5bLN/MtRi0QrXSEj9IlCIlq8xthRLN1HHt
 KkXgksFWx1kVpJge4pEYxdA
X-Received: by 2002:a05:6a00:4f8e:b0:84f:dd30:1890 with SMTP id
 d2e1a72fcca58-8616a4650cbmr4591857b3a.15.1788498817310; 
 Thu, 03 Sep 2026 22:13:37 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8614c699735sm747518b3a.0.2026.09.03.22.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:13:36 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Fri,  4 Sep 2026 13:13:30 +0800
Message-ID: <20260904051330.3804748-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903161031.1280195-1-daeho43@gmail.com>
References: <20260903161031.1280195-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2MFD-00007a-3K
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: drop pending discard commands
 before reserving device alias
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Reviewed-by: Wenjie Qi <qiwenjie@xiaomi.com>

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
