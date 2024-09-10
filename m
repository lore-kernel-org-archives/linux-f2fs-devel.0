Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE168EDE9AB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Sep 2024 19:13:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1so6IO-0007dA-Ab;
	Tue, 10 Sep 2024 19:12:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <axboe@kernel.dk>) id 1so6IM-0007d3-MD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Sep 2024 19:12:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=; b=I+suun2GneiQwlwmDt4IDpoTbb
 3xjlI/z2KqS5hVdj5NctfGo9KmrBy1C77Ziuo6fAuim8YiqrIt8Ok0NRIKADTprVd2qMb6JM3nMCO
 Kil3VwqQVu2HsEFx7b+bpnf2doMw1Qw/3lap7CwytoRlnPaB0wdsbkPIhZkfYL1bKJmc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=; b=TAAzazVPBkETKKrErjs6yuA6lD
 gbJW0xCZ22Hlm4D9lBzSDESeQICHyHdcAVG2cDru7E1d7jmLWx8oyLcnjIjdmoqZC3EBa16GEW0Mv
 FZFukw+oraO0mtW/slBeeWxrvLxvCKvYdfQXQSKJQtDAsa/Hncic/5ANIH4iVFVe334s=;
Received: from mail-qv1-f52.google.com ([209.85.219.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1so6IL-0001hc-4q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Sep 2024 19:12:58 +0000
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-6c353f2f954so42310116d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Sep 2024 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725995571; x=1726600371;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
 b=ujEzscHN2oSx0DPaUYbJllPvzYdcpjtcHC8r1JoKf8u5pmtA76/Uax/0FwqGq4K6b9
 JcQYri9gklZ4zB16/ZAn14UniEqq3rErtHxfpaLp6SLIaUH9li1tecLtDMCuqcUcoXDm
 iJRvaKKPIMnSM3QW+7TSsSS1gJEzR1FFiFKRH/YcDdbcNboPXDkSFz2LXiVDlM9OH1Jl
 fC/BqzvFD835JSO+Hjl1OepiWgHClN2W5Tt99mgJNFfdDp6AumI5ipV73xuGzsDVh5Ih
 sVI1kRDlpNQ9XHzTY3HDzGtk1LXFiIq/1cJAB3oOCNF9nl3jkR5k2q37ZxFHATmQAXnF
 0n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725995571; x=1726600371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4y68weuYe8VzZteJIbmlHGx6ZRCIwg+66SDRaOQ0Pk=;
 b=IbzvT4XlrIIi+2I8A7GYeTxsebavjT8zZJFYrdEB9WaPOYk+4vTaqv2WfcsOsLx0TB
 +yjSYQxDHJQ0y7RtSb7f/hqd7eC1mRwqAbdAkYWAHtALZ2IVtITTbjszkeisSRNjFN/d
 Yq0I9uqtdxe8Z1bRm/XicDdLG9rgUjfRwvBGHJIBvg5W9dmaZD2rQQ2defA8uTZYQHU8
 T/JutJ3grrnPhvDQ33lTtVPoQyCArM8F3UzkOLKd9CWQ0gfo9Q9XtwES+FlCS0LeMmco
 v7jj+/Gfpk5BnIn9Ea7Ec+sUXIGIVr3Saq17PUIUiyF1sDZP1nA3aQaKLyqPpr1oTX/o
 NPJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGSjEBJU5dzZfbisYyRV8TBT0j63ACrO4eIM6MOUtPRFq+HIFlfjywbtKtDnXyl8BeXYTW1qFPQxnFlPxOVGvn@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxDbwufCDCyV7zB3rklHQipNVlFKEsLOz7lEFXW0s+OIVSoEigx
 ujux4fjDIgz5E0e0snXD4++Zkll0KqoNuvthAEeEJBUXTt2sbTtSpRxTAxd0XppelzwXArAUHJf
 q
X-Google-Smtp-Source: AGHT+IEbci4bFKk4qyfG7I+1DUOrdPWBQtYa+ssZc5w3NRdfD9WSHDse9oCgXPz7cY+ZMf7HVvKJ8w==
X-Received: by 2002:a05:6e02:16cf:b0:39f:5d13:9491 with SMTP id
 e9e14a558f8ab-3a05745eb8fmr106220205ab.7.1725994094344; 
 Tue, 10 Sep 2024 11:48:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a058fd5c85sm21473895ab.23.2024.09.10.11.48.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:48:13 -0700 (PDT)
Message-ID: <e6792bd5-1bd0-4a28-b0c9-7e49f74505f2@kernel.dk>
Date: Tue, 10 Sep 2024 12:48:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
 jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org
References: <20240910150200.6589-1-joshi.k@samsung.com>
 <CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
 <20240910150200.6589-4-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240910150200.6589-4-joshi.k@samsung.com>
X-Headers-End: 1so6IL-0001hc-4q
Subject: Re: [f2fs-dev] [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
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
Cc: vishak.g@samsung.com, linux-scsi@vger.kernel.org, gost.dev@samsung.com,
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/10/24 9:01 AM, Kanchan Joshi wrote:
> +static inline bool rw_placement_hint_valid(u64 val)
> +{
> +	if (val <= MAX_PLACEMENT_HINT_VAL)
> +		return true;
> +
> +	return false;
> +}

Nit, why not just:

static inline bool rw_placement_hint_valid(u64 val)
{
	return val <= MAX_PLACEMENT_HINT_VAL;
}

> +static long fcntl_set_rw_hint_ex(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	struct rw_hint_ex __user *rw_hint_ex_p = (void __user *)arg;
> +	struct rw_hint_ex rwh;
> +	struct inode *inode = file_inode(file);
> +	u64 hint;
> +	int i;
> +
> +	if (copy_from_user(&rwh, rw_hint_ex_p, sizeof(rwh)))
> +		return -EFAULT;
> +	for (i = 0; i < ARRAY_SIZE(rwh.pad); i++)
> +		if (rwh.pad[i])
> +			return -EINVAL;

	if (memchr_inv(rwh.pad, 0, sizeof(rwh.pad)))
		return -EINVAL;

-- 
Jens Axboe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
