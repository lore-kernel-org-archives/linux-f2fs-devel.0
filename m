Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2F9CC6B34
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sI+mh2LI1okGb65ufz8fafuJtsTRmll/tNp/zjyCl/A=; b=X2vmp1eO0qPvlVPmK0ePqcQLy9
	oMPufWEH1XGRyavqXuOsZUJsawIC/mYZf+1Hvhn4HZx33cuJqRZRiJ0TS0fMn8ytGyz5WEuI6SSlt
	kUeObqyXYizlzMxVKCC59A7QKdS5S8o7jzdfjUbU2tqDTeUwYWRbcW9+CWKHwmKEgfN4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHH9X-00016A-Uv;
	Thu, 15 Oct 2026 08:49:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHH9W-000163-GG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:49:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YOjf6rFSyqsJTThezuuoSLramjes3+jmyhplUceJ4is=; b=TyKtfJXLfZ9oMki39AMGIcwKmz
 yTOcOjMcChg3EFA4QklBBxwB/0BMe8Ovr9XUGrzku2ZuEz5Qs+pRXReNX3mXwEM2CRxxK4FUR1VMa
 EQwujOODyd+HRaxWVNPS2mtZf6G2s6z7nDI8Jm5OLDt+7SKDhiFrkk6Rc6DD66JErI6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YOjf6rFSyqsJTThezuuoSLramjes3+jmyhplUceJ4is=; b=jEjg1veZqgmotUfe6x/3gp56hD
 rrjMiIhfkCRwRwX5D0d7RrneSL5Q3kEoMkXnXWSYN05BQ/YtWs4DC1Frox20tR3Yqe+n8D82FMIFe
 W0ow/vv1PcC/j1sDzDccXHfA0FmApk9g6zKQ5F2GjUB/uwBHj+mZr9uZl8a3EP1F/o8A=;
Received: from mail-dy1-f182.google.com ([74.125.82.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHH9U-0000zV-Er for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:49:31 +0000
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-30b6dad2382so11723179eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792054163; x=1792658963; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOjf6rFSyqsJTThezuuoSLramjes3+jmyhplUceJ4is=;
 b=mhlkdVNACifnoVN9HZdbiukz/oi0DBpPqigyc/O5A34zHemQRj/bnT7xjo3enyvvlA
 RIUAKiCYKBE6AvFa1m8aNIhzsI79nDhTAHIHQuNuYb5VkKdd3h4+uGYW30WC5CNikLLt
 B0GVF8hdKugnkxO2ypjlGdwZI+9QxO+fORpoQFPiYyk/mU9/CXvSdr4sFmKV+sTO7rDt
 Jft5/xdO7VziHr0O67wDkb8+GwbVDsdsGko1IfO6GDFtbfCsC/sCA8PDZHAY43g8/ITu
 eYRyHNZuAwUXxDf7ZHuGBktRut4HXYpIwSZVFPHSSN0aC5a0Q9JWPPh0fU4gn8epsAcg
 sN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054163; x=1792658963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOjf6rFSyqsJTThezuuoSLramjes3+jmyhplUceJ4is=;
 b=RpIOYMyxw2E7ttaSILLpj5d5NV+xjgxUAPoMRkK6P9JDev6uFc1YFmdFZtmtVuyXzM
 IcASM/3kqmxHopHyyxs9vpXdnsN427XCulRwX9hi41wU/Fgclc2vC2le/shXU3+rihHA
 e9Snt602z9WrucXn2ldSqNEF8bicoUJme5Uvizmbc0Mz6cT+iHmgJRebk3hZY2P5Riht
 iIMKrId8JhqhKGvRhXjJlS8wKrGnpUpSdS1L4tNXNptzhI6Gmch3r/trY3Wd8AXy/6vx
 CEbf7+eiZERC9+0WQI3NXimsc3xPcMOMQjphAJWANgnFgzBDRowh78niDxiy/XpmLETO
 kUEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkIn6u9j9ncCTPHPT7Ak4aUaOMtTvNb/r9yPXFtKhQoFm6NWWJeM21BI6eh4OD8LqqjV/UUQHUeGj63F1yZh3J@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIdWXXnpIGVG7lpp3oTNKLlOGyPWoDTVtTZF1b8zgkuVTCpcWML
 zmF/TrMaosSHxfhm6YIod8gorPdrfWe7hOjNfjPAQwbdCmXKBQs2SPQm
X-Gm-Gg: AYBFou13Fp0t+ehXeHKcFTjsbPyvEYSJ94EJuaAw6W4YRmrgs1nzxHA4me5S+1JF4Z7
 gR/RtLggJv1ksObjVs6fAqURK1f+fprdN387ksGzVua0iOZY+V8N/3Y3KtezCgVAqdDaUzEvU8J
 cM3xs3t3x3XpMtj3NVwebKxbCqeUpCnK12ij0UMvNMtr+zUBdi59hUmJNNY2Y5F8worbgxPUPuq
 HZwbZnGGL01EQgOc+5ynAGAlg2x5K+CLIL1ngzF+rc4OWDAqyyiATJFr6eVG6hPYM0nS67hwgXz
 QDdWjNIYKMnS+RIYyaiCcebWVoXR8pX4Ih7gFaUePAHFyBsKgH8yer7mXT6SZnZVhmbdJ8sK+QQ
 VVkfnfQz9eLbFha0n5Ei5kSrOzTaKLRHieRvuMwsKlTKdwfTnZ4ktd/BYcYaV7D0LtBrjuLnEC/
 1QIKAbtL+wMnfhvCR2KFilCx9vmn+fA2H19o5bpIU6HHpLp5wTc8j+kN7pORa+vKJwaUqujo7NF
 Xy+ChE5pU1lExZk0RM82owZat9A20J7z68=
X-Received: by 2002:a05:701b:2309:b0:153:7a27:b89 with SMTP id
 a92af1059eb24-16a5ed4008cmr29637644c88.21.1792054162846; 
 Thu, 15 Oct 2026 01:49:22 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a1becf08sm58191135c88.5.2026.10.15.01.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:49:21 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 15 Oct 2026 16:49:15 +0800
Message-ID: <20261015084915.3364591-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_xV4J8r6exS3ZdTA1aY_bjQ+PFL5LVn4ymLanxqHGqLGQ@mail.gmail.com>
References: <20260829060524.2656620-1-qiwenjie@xiaomi.com>
 <20260829060524.2656620-3-qiwenjie@xiaomi.com>
 <CACOAw_xV4J8r6exS3ZdTA1aY_bjQ+PFL5LVn4ymLanxqHGqLGQ@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xHH9U-0000zV-Er
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: refresh pinned allocation
 boundary after resize
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
Cc: Daeho Jeong <daehojeong@google.com>, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

> Could you update the patch to adjust resizable_tail_secno accordingly?

I've sent v3 [1]. It now subtracts the removed sections from
resizable_tail_secno, clamping it to zero, before recalculating the pinned
allocation boundary. This keeps the boundary unchanged when shrinking
within the reservation and limits it to the new main area otherwise,
while retaining the zoned-device limit.

The old tail-based rejection checks are removed. The current tail value
is saved after freezing the filesystem and restored before rolling back
the geometry if the final checkpoint fails.

[1] https://lore.kernel.org/linux-f2fs-devel/cover.1792050467.git.qiwenjie@xiaomi.com/T/#u

Best regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
