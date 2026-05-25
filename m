Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006AFCD5BD1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 08:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edg4KmkcxZA/W/gzR/t9LD0qfC/4VbYE/M7PEMQykdk=; b=N/qj5uxS1BA0MdHRlzgopXwpJe
	VMU8ngPVtqe0QRuWOU/UlzubDxmfQFSL/St+spa6uL0Om+RiW4Xi8NQvMiEAE7bK0LXIjjwH68HG8
	wHcq0paLT2PeQf7TVdIelpwMdaBhXl9Qc0tLcAlxt/3Oe57ITMXStaH1yHipY+UQbAVE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRQYj-0001SM-6h;
	Mon, 25 May 2026 08:21:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <anajain.sg@gmail.com>) id 1wRQYC-00019J-9z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 08:20:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rP2XwVbHYZOzOgD0rZjER3jPkSEkCdbeWs9oiQjvBWs=; b=DvHNPsw8jzWsB7GPoSPnagrE0a
 5AINQtGqP0BIOoNmekVXyFPyptQMgYBhLf03KnBkWuwUxiBV2+ZhUtNEdUvZZ4qptfvi65bLKJYPR
 uGecZUjlbJUd2TlToQuQj9eomRrIRkA6KYa1vTnUaApNH2S5jeMefmcTmM6ZEoJr+LKg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rP2XwVbHYZOzOgD0rZjER3jPkSEkCdbeWs9oiQjvBWs=; b=mAyl8JGRqsFH3nVeji2O5gz8tJ
 IDck5dopzdSc3vmn3UNL97IlKd1Qtt3Jj8tD0sIq1ejSGbtOcMTKvojsSiR/5hZ6Gyu1tRDEgyG0H
 7b0ZD4i3rJXDHlbfgXU995ny9TH25Wm6MimGY+Ws4kdRNaP2Zp9IxQpScrPuVwnfQzaM=;
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRQY7-00086n-Nn for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 08:20:37 +0000
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c8095d7d75bso3702654a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 May 2026 01:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779697225; x=1780302025; darn=lists.sourceforge.net;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rP2XwVbHYZOzOgD0rZjER3jPkSEkCdbeWs9oiQjvBWs=;
 b=LVLYl56Z8HleqFESr7m976B+SrOWYOhCFQbyNe3Dxq2BlE07BT0k5Vblp3IxG4h/PC
 YjEnq+LNS03GGD3X1QflE8fsHuecXKH4CT0LWd8BOKGFfa9AgcbgYmcZ4FU+UebM8DPI
 QN90Wrc2wX1eLqbr/ZlupSfVeXMtehRpJXbSnsnk73SYNFkF5c0x57S8BL7bPIvfXjvV
 BeVDrXBi4TgUPM2k3TvFCxqwmQEWgFWPHVulnurOKU5Rkt1txqjgG2VY/mE6Hosb67z9
 2toQx/VWMEupQ/LHVuhOeWKvgvY1fd1D9SrSTT0Amr6l5yZ2mR4WX5+eoaNlU3qsUVg7
 l3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779697225; x=1780302025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rP2XwVbHYZOzOgD0rZjER3jPkSEkCdbeWs9oiQjvBWs=;
 b=l/Md4nS/VjwPRBJJYaKVi5hAXx7LmYZzl7pex574l4z74pt20TTizSLlFvsiYE7LpA
 ba2d/q9Oz8T5sit23CM1iWtjkqqMko2TDq2VvhH0/zL0qs9m/FuqQ0NhV7swaOL6vqEE
 EVE3b8ZXaVBhT5xT6hEPJszE5bROS66wsQPFk5qEu/fCUFsp1JRrRhzu5diUppQi80Kl
 9h+WJpi21kgUYCTiE8jnbrGaex1RzXeM4i6wtr+GlcfLsm/JlEEypcnuXpZ2yh4lxwB/
 sGRuwuji0rBf+NucZAlIySBWHSMIfoQNtJWDuQ99aWnbUF1pTrQcDFu48jeyyv2BaeF6
 Tv6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KX8HMJh/5lIExjrChgRtgpM1Tek+WJDYLQqqKjjFpFF6z5QSStPRBzGP4keZQMQXUc/6CMDT9q79aYdXweG8x@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx19VkIZja3xQM8WxgsjXYEdJlBkORcd/RuOPvsVBks4UR83p6b
 rsznYHMfolGkAB9itGVeq5hAAexyWnQubma84dwqaf5Spxc8bxM3NRSXoOlQwA==
X-Gm-Gg: Acq92OEoQPOkmlZGhgvAO9bVcjCp1RElzyKKs9ntKOQDVeZ0g/43d6Iy1u2oTafUNNG
 paI116fQ4OYJ6G0H7hRmE6x9w/PNjh7vFQYp6zIEBsXdAVC6xa1zWba4e+6Yre4i9D9gykoZEGV
 wJ0HLeuuIXNxZBdvw4uTrrzt2MtJ3/iXDYmyn7Cug6RYa+0Lz8RK0kbAYmiwu1prTZfYx9VWwtP
 ggSNCZskbK2f8Zye439LXg0J0whVDrQXICps6kSXxhv+/X7EqGf7O3cHXxYtVu2Z1mDANe2qVhH
 nh/z0dZX9IeXROiR+iz5Cj+xxHI5SZMSZxZ0evvy5fkcTFtdY6bxH1yG76XFS1irOVSY9n3f6dZ
 HWKSSA6PorjKf6VPlnUT7rfPn3nhSbuCCBCi6hZmeZix8njjxDl+pS9/sel2BszPaMHUBh9Ippx
 GvEKdtlWPI7VvzUIceKsJvrdmiuzw=
X-Received: by 2002:a05:6a20:3c8e:b0:3aa:55eb:a5fb with SMTP id
 adf61e73a8af0-3b328d15f18mr14912245637.23.1779697225436; 
 Mon, 25 May 2026 01:20:25 -0700 (PDT)
Received: from [192.168.50.90] ([116.87.14.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852056d767sm7212551a12.25.2026.05.25.01.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2026 01:20:25 -0700 (PDT)
Message-ID: <0f774a12-7355-45de-bf95-4c98193d4727@gmail.com>
Date: Mon, 25 May 2026 16:20:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@infradead.org>, Anand Jain <asj@kernel.org>
References: <cover.1779367627.git.asj@kernel.org>
 <bfc0c92a33bf5a129dad4c3e4c76973e7a6cec74.1779367627.git.asj@kernel.org>
 <ahP2OOXmwsM87j9D@infradead.org>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <ahP2OOXmwsM87j9D@infradead.org>
X-Headers-End: 1wRQY7-00086n-Nn
Subject: Re: [f2fs-dev] [PATCH v5 04/10] fstests: verify fanotify isolation
 on cloned filesystems
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



On 25/5/26 15:11, Christoph Hellwig wrote:
>> +export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
> 
> Same comment about adding new common bits outside of test cases applies,

Got it.

> but why use both inotify and fsnotify?
> 

The SYSCALL and stuffs until fsnotify_..() are different,
so I decided to keep them both.

>> +[[ "$fsid1" == "$fsid2" ]] && \
>> +	_notrun "Require clone filesystem with unique f_fsid"
> 
> Please add a comment why this happens.  I also have to say I find
> the if syntax easier to follow then && with a line continuation.

Got it. If statements are better for readability.
Also, I'll add comments.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
