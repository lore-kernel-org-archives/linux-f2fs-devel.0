Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E92C624D0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 03:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+VDR9NBVk6un3Z7ovoH/Q7Q+1zqzaRRdlEOv7G1AIU=; b=FH8Iyz3eg8M8KiW2Xll0SVrZcv
	YjzWinBLsD32shxKaIMZfMbihB7g/VOUu0E7K2ftBsouRe5EZUqcZqUMvpem8lzy3H18WMN7L1JKi
	k6336MgsgrG7Nbx4EpzTxFIoHXsSw9VInf3LChJBwUjHikQ+oyFe5ABFWzVuZUrY5+5Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1bcP-000300-Np;
	Wed, 02 Sep 2026 03:26:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1bcD-0002yk-Hk
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 03:26:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=dX2GrAuOW0ULliojk6gIxp54+j
 ubwoCd0gHVMpXnPqYmpd6qth5IsdPOhYkfnCYSirwtbBBBXU4tvFg793+f8T9gPU5yzNiMXpj4Vws
 7XQEfa8SdtYUnFy7aKhjHTEENOKkDnX3Qwf1BGpQAHArMit2IZbObd1oyLY5gzJyS6cE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=ALRlqTzq7nMFW10tbuXzudTkAR
 BCXhfEn2Se+RieLmhMwgcMYS+q5s9gw/T3HMUSHSnDUH0OkvMZH9+fML+3iZ1scxYOcnkYcGptE5Q
 xQUab7tiJ9/jdNJWQ/dnnLMN6xaL0i08ualwf3dQJspNFd0iVthI73J4qeq2QMzOCf0c=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1bcC-0003YY-SY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 03:26:22 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3966791a6eeso690715a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788319575; x=1788924375; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=T+0zeP5l/P27M1xguTl0FLDFRS58dyQfqhpcniFUtui+p0nfFxaRISlyIkbthTGafY
 Osav3y/bngFrfQp7QNnDLG/+j8YepqepcJqtN3feP9kX9eMEYOTtpBfRKezJD9UyOm+1
 mfkZH/5BkNai/R7w6vDfeVFLVSzDRmBAJ5mJEiNNUd8c0IX6amyMHb1NV3t1rf4aOUYn
 +W8e1J4WdABZXtZwEvS+gm5c1YLzfTyHQnYGw1i7i4GV+TXDlKlJshmbM0FTHE05vx/5
 O2F9tPEa/2kVGnpiSpAoJ90Wtj5Njp+ER4fLDMVI5BhI6JKyU4+3sgLiuCEZylCZ1xds
 7+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788319575; x=1788924375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=bqNGggOtYawGDDlx+uKAIHqhY7fVAm+dTGmg0A9oYyqmaPsPgxLkHT52j2KwY/mu5i
 29rSssrTunzolcqrDUasqnaXp7GKysPq9RF2SqZVjV6/DW5m0lS3/HNQ2c6nyeyLa5WJ
 oAFgjdcyYlOcJAIN8xlL959De5vUT+1mrIhuB0ThRxAED/GZ8QyR0jLDYuqOnXMsDhwu
 pqpAr8U1mlqoDsQNbapDbhpEjQScit1th3+FI8EECUbUqNFRdsG9RmeQ0tm38SM/ytHv
 njlJVr18/ydBiGD1M40adyutcq6hieJxU2mNr+CcLc1lyJCntj8n1t7SSHmkVRTjzqAR
 OXrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzd9XcVV2xUC7mNwkegOH7SMB1saspx/3Y18uQkXwKG/BrECqHQysBYubeCZ6+NNzumJvh6jqsQAAFRVtWglI3T@lists.sourceforge.net
X-Gm-Message-State: AFuF++kkpeH+ulC1pSJkHRXkjpTC+lVaRrJqxY+lUX3E93ymDGSUx4Eu
 idC9O2SXGCEfVBTKVnfKvdtI5SRHS4zbf88iWeAPYpEB4EywSnHpTek0
X-Gm-Gg: AYBFou1fR+1CkbnreQZSKMRrJ0MOlYvO5HQBqLozwmRPNb5atP4w+RmOn7bDOliPyKw
 N/N6wwj60uMSQcYZN6IMhcTYMXa8Bysfh++3NjeTLxA0stLeqrLCMOhcqFjHILpyfTALJ0vBs/A
 iYiOh9uJIBCNTjoOVHVM7Wc3XOL4SaIi6kA1yP/wwtj0jr5uIGVrR2qztRkqL0oz7IWpomWtppx
 So4lDXbn3xLjfRYnX9k42kUXH+7X+UEVEs8dQ8+Spc4jkHjfS3G9Zbv3fEvt1W47R9wZZU1Yh0L
 FDwtN9jBYLdbwt8Hx4H725FP6YDGhE8p5dPHRcjFBWm17Ay+Z6TZAC1Q7gOhJHERdcbuEOjYg1I
 8TFur6YUB4Attbezl+QZZwBnkETy3F4mHDN4qC/daLuLSYJUF+loqODpDJ1MGAZKo3LovfQ+ucR
 kHI921n0LtBaKSiPJNIaOs1pXca7RSRivj/A3HJBu0OoycUarNdAgXryzSx/9YP01To2cISKpuh
 MPoYt6CiwBuadhgfj67BjISht0KD9dbfuM=
X-Received: by 2002:a17:90b:4a8e:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-39aedcfc81bmr2701816a91.0.1788319575125; 
 Tue, 01 Sep 2026 20:26:15 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae380d7a9sm2569843a91.12.2026.09.01.20.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 20:26:14 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Wed,  2 Sep 2026 11:26:07 +0800
Message-ID: <20260902032607.292561-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901201740.4040807-1-daeho43@gmail.com>
References: <20260901201740.4040807-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x1bcC-0003YY-SY
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: drop pending discard commands
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
