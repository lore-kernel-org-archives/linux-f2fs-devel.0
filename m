Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AEBCA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1iBxTL8ttTTddu0temUf4LnziWT2IdJEJ2VZRLWFsVo=; b=Bme1KN1P/0yyrfxh8yYwVawq4T
	2pkCYWK16aUB9QLOe0Ys1B/tUBswL3392OREDyxOocWSvvCcREIfQ0hnPW2rPv65Ji5/wM1/WDXgV
	kp7JnslhHJC8/7QF35qoMT+q/8Zbhde7pm8GqHDVdfHN0lx040t+HP7WNqtXSfz5XwAE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF7bu-0000iO-1h;
	Fri, 09 Oct 2026 10:13:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xF7bt-0000iE-72
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYXNKmY4LQUdBMbioRIMCa/Hf9fKGkwJzJMs+UpAab8=; b=T8MoouW3Q3qDpvT1+ip85Dd/2m
 28lekgyP5WHR4/q2ou+Dg21IBV7ryp0hmHSjgQFXWcrku4NE1uZ3Egaw2EW0HV3fPIkxEpRyuj9S6
 Xm+7Pwk+6YFAP+ouEJThxpso4Ju/Q50VylRLUtoymmukB9vgVCYdUDLynD7C3YBnpqu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vYXNKmY4LQUdBMbioRIMCa/Hf9fKGkwJzJMs+UpAab8=; b=ZYEGKYFTfv8SE28dnJ4DSbL5XV
 DsYW5q1DniioRYP8GykhfCJeauwseq7PEle0GWJr3zYwWaRh2j5AOIUnlKjCH9kWaBqWoaFg2A+ti
 OhD5XHaCf3ekVE9bsELwN9hQn2d6Ce5hZ2L8oVNNv3pXD/vnshjasi+uXTp/x+oWIJc0=;
Received: from mail-pf1-f181.google.com ([209.85.210.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF7bt-00045D-K4 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:13:53 +0000
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-890d52c7c7bso3450709b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791540828; x=1792145628; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vYXNKmY4LQUdBMbioRIMCa/Hf9fKGkwJzJMs+UpAab8=;
 b=kIGyBPtcSjrbvwcE1LfPO5CoF5kKiQdFUrtH5BqWLEs8QLRlKSq/Ni1JVPuDH7pnl0
 dJmx/vd6VOmQPQioYk+KrG9gskwoF40mEmpIFjuSDd1RhzKZgD+TUgwaxfrt8C5EagOA
 Q8qvNk+ewSikkcxDE9bzBHbZ4f7u9fn1WVNV/9/7FvvCEncQvVELk71Hl7k6LaVD3h1D
 c9dOd8uwhgnhvA7oOrMTkgzoZdBa2ltJcWqSZsKViGM5IlZkL0Tmgs9bG0FxS5797vwp
 7TqZYzIq1rg8Xl36ZFeHKJvFi5RsLHvvTnmkzi/gzeOlzkM+pbs91qRliGfNTVvfnzig
 N3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791540828; x=1792145628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vYXNKmY4LQUdBMbioRIMCa/Hf9fKGkwJzJMs+UpAab8=;
 b=o6OTBWPN50KjvMD1Snu4nXSy9/JdGSdGtiSedbIuAhLxribxRkXOlVJORtN2U0ecSx
 UqsxURaGmlHzO5COBOShFfGo24yxS2lQqRXbq3XOMoB9zlyLIiCNIksdVKfUcjoJgoge
 Cb37b/0qA5M8S4yu1gebHkGqIehm2MTN5xXI8fQQ0/zwaUeDpAF0mkwxbPSXU80BfdIM
 tuFrJv06UaJ8L9YJ9hWGM2fVo82QeD6a97qBQKbWVIaZRCzcrHUG1EcPdI8G+4DqRVUX
 TbGSWPyna2eyOpW1Z5uqrHicDEPVuiJ5NMIMCpxmrTrOJAxvH2nWCj2l2bYZSQG3hN1z
 fJpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByL+lcxPRBIroczv2iN7R5h9Kam/fDPigkA7qzsLnhK+9dOveImsX2svVLPjJOMuoPS4mf7NhUhqRYfT7JPCwcV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKIf0YReoa8kTf3NSxeWR7E/ju7fKWiIy3HVdqYFgt7bZUxyl6O
 Bf22rMJf/rJi2820unwAg3Gpr94KQOjs3+zyduSnymuAJ4RVKyW6khAh
X-Gm-Gg: AYBFou12hIqWPJX1w13VzZ20j5JLWqWZogx0kybOLLEQX6OZDvW5X+EbuZCsyYDvOIm
 DxIKsoWw8Gow0EtxljCOF64fDM5zb2vkmUIRgtbELgKNDnGPy15d6gZp9BcPSHz32ZPVoAGeyC4
 rupFtAtll6NgpYwF+0WsbqobxSF76q1A/o13m4SozP53K7eui9XGJbRi5dqDGK1yrljokpa4vAy
 3G6IfCmQppktx4TlYakzRUOTG3m2TS0y7cZX6PqrErGFBkZc1YBukEpFM1rRfQdjUFCTqbZZRjS
 Znn9XQnmp3lRvSMr4aH5AuyVxWMuQyEvjur4CjnA0ui+jAZdx6Rj5HCmYjCRIaJZWkeM6x7njDn
 GPBNnrG1iKthMeP8+XsjO59plXH28KgoRZAGOAE4Qw0npUIrFoDQ0C9cJrePZp1g0nZ6QtsnmOR
 wWq3s4ykmvnQ8L5gqNECDCE1ZVJq+LwqQLhD9kO1KufB1XoaSZtzPn3jYDdVjNp02cjrhlYBGuz
 o84YpwrQRCwNXcb7nPHwbD9Qp7crGaDY9s=
X-Received: by 2002:a05:6a00:4295:b0:874:706d:856a with SMTP id
 d2e1a72fcca58-897c79daa3bmr1137358b3a.27.1791540827847; 
 Fri, 09 Oct 2026 03:13:47 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c37e2238sm683707b3a.22.2026.10.09.03.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 03:13:47 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: chao@kernel.org
Date: Fri,  9 Oct 2026 18:13:40 +0800
Message-ID: <20261009101340.3525944-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009091857.1326197-1-chao@kernel.org>
References: <20261009091857.1326197-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF7bt-00045D-K4
Subject: Re: [f2fs-dev] [PATCH v2 3/5] f2fs: cache: wake up f2fs_writeback
 when exceeding threshold
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
Cc: qwjhust@gmail.com, jaegeuk@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> +	if (dirty_threshold && nr_dirty < dirty_threshold)
> +		return false;
> +
> +	/* don't wake up f2fs_writeback if both thresholds are zero */
> +	return total_threshold || dirty_threshold;

There is a related case with only the total threshold enabled. With
cache_wb_dirty_threshold=0 and cache_wb_total_threshold=1, clean cached
entries keep the predicate true even when there are no dirty meta/node
caches. Writeback does not necessarily evict those entries, so the
thread can keep looping without sleeping.

I checked this in QEMU using dev-test plus my both-zero fix, which has
the same predicate for these fixed threshold values. In a three-second
idle interval, the writeback thread used about three CPU seconds;
the total cache count was 22 and the dirty count was zero at both
sample points.

Should the thread wait when no dirty caches remain, even if the total
threshold is still met, or is different behavior intended for this mode?

Best regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
