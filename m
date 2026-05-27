Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE195CD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0vuU1SC8MGFEAaAP4Cn7Cs7CV8nhjw55R30ihZcTGwg=; b=OhGOKzk8pLXtlMNzakJq4z3awx
	LYP5837Ea19TCPmS9j8Vfunnm5Ej1twEnwWgbLCzGl1ACLlsZ8MDd8AAqCKoS1k//g5pyUHjaAgY/
	QYigABwI4a4r1KU4aBvj4HesEoZuHpNGyzngLyWXqdipsKBOPOiLNGw9OPgWirx/nFqo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSMwh-00057W-Ib;
	Wed, 27 May 2026 22:41:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <anajain.sg@gmail.com>) id 1wSMwg-00057Q-95
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 22:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PS1QiPPseraqYZzSGuyGeQTFkHJ1l+wgxnVan1O+b0I=; b=TFspbbH4DQnpXBuiKMXmUBOJ1e
 JssSDlWoGCQA0T0k4V5eWX7yXQIvTe7ARnAKzzsW/U1SAn/AeAHr+UqlIQmJEqrZmUby0+uqgKqAQ
 LXBF4iTaamydroPYMyzgxamRnI5AzmgOCey3g7BU72Y0XP11uTWS0eIcbgRlf1IuRglA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PS1QiPPseraqYZzSGuyGeQTFkHJ1l+wgxnVan1O+b0I=; b=KdT0wma3W49gjcmZ1nmgnoZuEv
 Ss4i1ZuCenzZ6932/LdHhL/q5aO2UEiImYc3tvc6iNvc3PFV6EpKjY1lSpzhKlYidMI0zzozogIGz
 xQR7jNpIW7VvoRrAW2UMrWo4v/DrhxcMu+Qcyh0YczvGKfiF36mQkzXa2KbO+7NJVKw4=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wSMwf-0006f5-8U for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 22:41:50 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-83538fbd0b2so4996224b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 27 May 2026 15:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779921704; x=1780526504; darn=lists.sourceforge.net;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PS1QiPPseraqYZzSGuyGeQTFkHJ1l+wgxnVan1O+b0I=;
 b=IdBnbs7xY3n1Ws5GZCCgDEN/G9SH2ODnQatawSLvDmUqJUlEFIa+Mo5OpVEQT2+61H
 EyUoly3Jdi2ZzAO1tz7CejH7z376pwWaKc7hWz8paX2kDVXz2macd8hA4QjNfiJ3eHoX
 b5BOS2ejfEeTqx1daU+lbZqJHiUNNyyz8fPhfQCHCB27YvkFaQFF+liE/tbl9WKGoI0H
 t5KjPLIvYmoFHsdPVpSKuvmKf+DLkI9QQzk15Tmn0SLjqg+qJYbZLCfF41v4qvJKkVvL
 cI3BkUmvfw5m99rw30nH8a9WIKACLE43g0wtmNJ7MMweOFGcqRQfdsDhFnPbCf1jh7m+
 xzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779921704; x=1780526504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PS1QiPPseraqYZzSGuyGeQTFkHJ1l+wgxnVan1O+b0I=;
 b=MJaId+yoiMg0sRlah9dPIKc5nOATryz4xeBPlpgHzv04l/ggG1M/FYQQ0El9JX1r1a
 loWMA6xqfQqWK+P+H47cq25PAIigXsE/QMTqh5YuSaQ92x+LxQX0+ybIDS3pHjWl5gb3
 vkzqDHEgto6Y1AUPiGgtDTy81hhbE4vBg69GoqXsIpO2ebiTIFGwsDdupG+l69dSliOJ
 GQaFY4whH32n1TyTod6N94D8qW8CHrifPcL2G7IK0ufBM8ek++ajd+ouhciEbt4oS1Mp
 8gjty6VNfXEKtxg2DnP+RZK7dQXRBR0i5cCuNUfhgCMBlXk8EnzYPfyYMfwwXq2DeS7o
 uh7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uGmXhb1X4plo44Ik+ncQrbx23OMXXblfo8zRui54WA0USPmqxMbV8j3IqqPvBHyABd4/BqQdj7v2THvXVsVgw@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy1D7/lsAN+fE1WKGlzxTMeynEk1FY4XdwZ+ne6UOPdLcWYamcK
 Gb++bgxwNT3zgrTVi7FgVipZuz5DeJEG2CdEPJQrWB0RQxQf4PlvL3Zi
X-Gm-Gg: Acq92OFC3gSr+YvXQ+Vf5xJsyTklC/EFlQJDmALm/SViEydyo2UlHFeAYVYhQzQe8RS
 nEH4ClkGXSI5u4/JR9+0VcIDjnfqhOf3+SRcIvxhO7UEEUgypR9cLWY4KOjWmyGQPZxJdE7qfAd
 jkoSsAs04Lv9FqKxcKpyNLt9dKHaN2RSxC60LGO3K8NVmpKyDLM5a9NusjpxgC++wXEAl/BNZJp
 z/jhifVSc02cOZfywZu6yW7X8D5b49K0uNSEFWXYPLCZheAUEdvRcN1sycPCcp8mEIu/N9jqA2+
 lVkjTtJ2Zn4kpTVrbqlP6L1ZtcC3awczigBLuRPvAsPN8fHv5o3tVUioVaEe4mShh1sKinRFcgN
 VWapQ6tPBfivFUOvtwBwhVZlg0a18oNuHWHV+Lk/utcJwHzDBI7AQndEiOso+GrseHSqcgxTeIj
 RW5/sNC9oZaaVk28p2vpE0b2qENy4nxNEeSNfanQ==
X-Received: by 2002:a05:6a00:3a14:b0:835:41f3:f453 with SMTP id
 d2e1a72fcca58-8415f3f67d5mr21283194b3a.17.1779921703896; 
 Wed, 27 May 2026 15:41:43 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d6eac68esm3382981b3a.15.2026.05.27.15.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 15:41:43 -0700 (PDT)
Message-ID: <e039c677-073b-4201-8588-ad84d58639e4@gmail.com>
Date: Thu, 28 May 2026 06:41:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
References: <cover.1779367627.git.asj@kernel.org>
 <a24645463979d0550e0010030995b0ed609215c1.1779367627.git.asj@kernel.org>
 <ahP2hjv9zl_WL1kg@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <ahP2hjv9zl_WL1kg@infradead.org>
X-Headers-End: 1wSMwf-0006f5-8U
Subject: Re: [f2fs-dev] [PATCH v5 05/10] fstests: verify f_fsid for cloned
 filesystems
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
Cc: zlang@redhat.com, amir73il@gmail.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 25/5/26 15:13, Christoph Hellwig wrote:
> On Thu, May 21, 2026 at 08:54:55PM +0800, Anand Jain wrote:
>> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: use on-disk uuid for s_uuid in temp_fsid mounts"
>> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
>> +	"btrfs: derive f_fsid from on-disk fsuuid and dev_t"
> 
> Seems like these are stuck on the btrfs list.  Any progress on that?

They are in the `for-next` branch of the Btrfs Linux repository:
https://github.com/btrfs/linux.git


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
