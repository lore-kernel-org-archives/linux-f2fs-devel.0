Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E228F8D762
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Apr 2026 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OHsgxJzzdHUell2FX1nKS/ctlgLFWuWr7+L1KB/Xodc=; b=IBOY7xHLU1bSoHd88ZoTPaLwX7
	CHYwJK3Mlqd0+Gfl31BxwgV8frnvJOrbYXLdmpK2ggLLdqejCirBvxmw5OmERFkGJ86L8HC9P8Qy/
	mx/nHkG4XajqxH2rTOqeeoW7zNPdNAaSvWgKZxdPb0sHiD9yuCfZTMvHdw9E1FHZnrF0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wDPpW-0000dl-Lc;
	Thu, 16 Apr 2026 16:44:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zorro.lang@gmail.com>) id 1wDPpV-0000dd-8G
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Apr 2026 16:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:Date:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1LJ8LfPaSbQ6lDGslM73KZc6YjmQtWm3xrl4bEFZYHU=; b=Wkgi2CsfWl2sBOOxuLEtH06fxI
 s5LZqyktFO09xlJgIg8iooBFQp1HVA14wLKaFEoQYUg+FIIzRq8LHI2Ct2Jmvf8K6xpem1RQZKq0t
 2Dsr3bE8A7TWBgiGXPsaKmD9U0VLzAlViNP87l5Nq3RVjzQJQNDd2WEjR0y5yzQTuL/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :Date:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1LJ8LfPaSbQ6lDGslM73KZc6YjmQtWm3xrl4bEFZYHU=; b=LBLpz1DBzE8IwSXj17oZpazpds
 9A5jtkkP1oChr2KTd2jwh/wjZDfnfJhQDLxMRiIFHothlV/pWMtPG/vEmKClsfOg+pt8N97sBPFsI
 XwYQConYWnshJxG7oBd6Jv0ZQQ8Hild+qOA82qF69ubMQg+ohBcQhGf01kVCHSsgpPVg=;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wDPpU-0002F0-Il for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Apr 2026 16:44:37 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso7067864a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Apr 2026 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776357871; x=1776962671; darn=lists.sourceforge.net;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1LJ8LfPaSbQ6lDGslM73KZc6YjmQtWm3xrl4bEFZYHU=;
 b=kTyBFjBoP7L+uo5NeWklHT7C6tyXZfZgz7hIIC9WWiwP90HAGhmgpjDeczP2QHcunI
 WOqXazNZ23mYezmT0SuLRMN7O/nNYiUGwh98e8cA8g8HxDQlPzA7qH6+jT/T7mOMoPDn
 zwxI5W1mod8o3x4HbSNnMaxpqWRLrkNRBx+9ccRwiewpHpwSP3rB/SYanv0md8niXcY+
 E7zwsrK0lixf57eOn3ubBo7rUWPPPLsKYrKgLtF9rRAtGNX2wzPaBqNKP9BVS5iaKjo2
 FFS7qwFMOo6zrM5g8OCI2dEtl/ueYNa7/Xg3TvX53QSmCEv6WcArkoqxcAsPS8h77gib
 aVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776357871; x=1776962671;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1LJ8LfPaSbQ6lDGslM73KZc6YjmQtWm3xrl4bEFZYHU=;
 b=AZdTECPPT9luNIjGCwzNjmtVwtpBOekcAWmxqCPmeBsg066rz2QGCbAsDFjnJyKMlq
 TUdaK/RcQiKpHz17uYL3HZGMesUHyPbCd7kauU10aDSuy63pmH7FnNccHeRn77mgZvNn
 6c7XR2JPAi4VOhc1VCfemstgA3cLmhnJq8gnpRdMKGXC3Mb6e+rwBO4QnRYiz+oFnBH5
 YmBKgE4TjmUCG9vPaU/pkqMrEdC6hBI+hufRta8dr3tirpnxdVzMUeIbWiOIBdSeMcTz
 KxXdQ6HOdHloqp5zJVbIWpPryGqBd7yldcHe7L2fuFQWNZ6vz1c5neSIR9Nv1ivt+sZm
 lzLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ94nSfhVgW6vB6hBIp8eEiBnXP/9WKEzf0gcCB1VutMEKHHiY20JMJ0Ri/WsCPOmOphnn+zlT8nWeVa5jLm48ft@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxfZjEaXb02rDVYUjawQCIlzHy0DfeZFN3b2Q3lXtccGxgNRT1s
 XVqvfzsv18vLF5a9f91a/WpG2oU99i4JbZXmnIqJphXPrJZhJRoCMsNQ
X-Gm-Gg: AeBDiesuahZbdyOuCTIy/pjiJE6/HA/2o8OA8UHmzJYYBlup4Se+S6Dpr4VOvkP5mHT
 x5F7srS//atWlYyGrbteSWo3sSzFTRFLxgiTjksktvydFWP/qrp55Ck84erOzLjB/4uoUCGCYV0
 1NHEE9eNb7k0xIDXM3uSF2ZZtos2UlBOAxTykItuGV67o2CvnTIOmgSOm7IkAhVv8pRc5R4QX7O
 i4eckXZ/vspXrr6WKBfc/8r7/vTrskYTeCwKmZ7EkiAyCG6IhHY9oAWsV4oHfCer62Tx+Txyy1k
 4kdl8iy63SAG2Pxf8oG+pbnPV6dKxDvEdPoPU4oq/hIiwU7k0zQcOianaqnvgYSXdLM0lpSLeuD
 MYPYIG7INmfeg/q1PFXJF/Tmy5PZ4Qxens1e4LoYsmEDB11Aa4i+f/cDIooBXyGQONhpyPhufT7
 zby+GHIfstmcMdn6cBjc5Q
X-Received: by 2002:a17:903:2290:b0:2b4:59d4:9a with SMTP id
 d9443c01a7336-2b459d403abmr204096045ad.2.1776357870507; 
 Thu, 16 Apr 2026 09:44:30 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478109ab5sm60192625ad.19.2026.04.16.09.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 09:44:30 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 00:44:20 +0800
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <aeERuvIUU91WKrz_@zlang-mailbox>
Mail-Followup-To: Jan Prusakowski <jprusakowski@google.com>, 
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 anand.jain@oracle.com, wqu@suse.com
References: <20260410131821.991005-1-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260410131821.991005-1-jprusakowski@google.com>
X-Headers-End: 1wDPpU-0002F0-Il
Subject: Re: [f2fs-dev] [PATCH] generic/050: handle f2fs as nojournal
 filesystem
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
Cc: wqu@suse.com, anand.jain@oracle.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Apr 10, 2026 at 01:18:20PM +0000, Jan Prusakowski wrote:
> F2FS uses a checkpoint mechanism for metadata consistency rather than a
> traditional journal. Roll-forward recovery is only needed if there are
> fsync'd files since the last checkpoint.
> 
> In this test case, files are created without fsync, so there is no
> roll-forward data to replay during mount.
> 
> Therefore, F2FS does not need to write to the device to recover, and
> successfully mounts on the read-only block device. Thus, it should be
> treated as nojournal in this case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> ---
>  tests/generic/050 | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tests/generic/050 b/tests/generic/050
> index 3bc37175..3a641a65 100755
> --- a/tests/generic/050
> +++ b/tests/generic/050
> @@ -46,6 +46,18 @@ elif [ "$FSTYP" = "btrfs" ]; then
>  	# So for this test case, btrfs will not get any dirty log tree thus
>  	# it can be treated as "nojournal".
>  	features="nojournal"
> +elif [ "$FSTYP" = "f2fs" ]; then
> +	# F2FS uses a checkpoint mechanism for metadata consistency rather than a
> +	# traditional journal. Roll-forward recovery is only needed if there are
> +	# fsync'd files since the last checkpoint.
> +	#
> +	# In this test case, files are created without fsync, so there is no
> +	# roll-forward data to replay during mount.
> +	#
> +	# Therefore, F2FS does not need to write to the device to recover, and
> +	# successfully mounts on the read-only block device. Thus, it should be
> +	# treated as "nojournal" in this case.
> +	features="nojournal"

OK, so f2fs is similar with what btrfs does in this case.

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  fi
>  _link_out_file "$features"
>  
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
