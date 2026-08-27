Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B34C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 02:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+VDR9NBVk6un3Z7ovoH/Q7Q+1zqzaRRdlEOv7G1AIU=; b=T8pQH8q3E69GXliUKGgoM+fVTt
	rP3WxoT266anL2WH7gIRcyeGJ/Dwc+gWv9Q/uCzU6XHqmE95VBpXVHsOasCI0JspOvov+UWYqJvKD
	EwDV9fjcyUnc6RvDHw/eUHI4yPPfZAYJgl1JBlCvsFMS9M7ILyV/YCJk9vRI4fMymtGM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzPqw-0000Ba-DF;
	Thu, 27 Aug 2026 02:28:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzPqc-0000Am-CR
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 02:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=NY+hXdFY+h2j9zjFVL/SyPDYru
 RXKr3vV67xWd4MmhcTVi6mdWs/VJQJdXWg4ohrURQMZxQ1GHU+Vv/c253J4O/AIjzYpHxQkGWybdS
 RbfGI5W6FUoX4tBoZwrZE+L9V9q2Pp2naBm7mAvBy5Sjdn5MdIVy+obGzlF61bk9A2w8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=eFvk70BOn/pAHhijMsMoeSQ/NA
 4AhCQrD+ZqFH0kG/coAATSG/IHcRCoKDFbhJSTKw77aRf2oT5CuifIsduFnjiMGjAA452aPHaMjak
 GWPlDtQmpNoqHCaQQNK9l74SMiScXf36gFFtDNZgl1+0m/Z6t4jw4XdFUVQNYoZq7fI4=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzPqQ-0005h2-QL for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 02:27:59 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-39675172593so1416878a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 19:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787797673; x=1788402473; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=V0PsxXTQ5FMQIgEzQc9VqFcF2iQ3KknQz7EgAZpD9WJ3TiU4N/qedPG1qL+XcqbFPn
 4UnXWxSr+E/Nx12RkCdafZIJiUKZuqW7wRxcMZ2eY3IBO3bV9gjvQyH7aTgyf/D2E+4J
 zhq+LLY54JLYWT+/5qKtxq9AEstPVOmdcbYNKFkSE1Dp51wxzp2PC94WBQBRmE1Wc1cr
 7XsswXhdNF3POJ9g52VOgN/Z0aAbon7ZP9bulgNEK34wgONlmwgMmKP+hHnhuMKU5iKU
 yvhsvJj8Yjqt/Fca0NKg4w9Xy9h+31Ph0E+s4iI/KbB/uPBZ0IeNk4jpwW0haptsx4BH
 TxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787797673; x=1788402473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=q6UFPEmlcR7QgWZp588ZHTKebmd+x2VaLYhglefMddblGgXYTwCUx6fT6UQ1S1MFgV
 CO1FS4qyVmDZ0HnfV6HU0XAFhJwn75glKDhHV6UtKRhVa4hhJIipMxbBZRI7dKTX0pUL
 nUWTReSdcQ4D2u1V2SXTYs66ZQDjNI8jpUs2s7ROXqqW2UYoDCtvAPwZWgPu0iQVYAAE
 fvc3+wdYhppznKpXlyY/UolULOmSdVN1aE5zRlfyiygksRwTCRlK51YbYBa/CNmNXtuC
 +nOaeXw8HbNCEUVM4IRcjhWBGMrHX4/GVhE+gmz71dEKUl460xjYQLV7u19psDx0u80O
 dFlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQw9xeI5pqVKnp2veQnToS63b+HxmhAfV6yPYKLVbKQnhVyPK38GQ02HSxNsqc+3nl9qfIxMScQF+P3L9JzdnK@lists.sourceforge.net
X-Gm-Message-State: AFuF++llyw8YqnBfQd0NCRGyHOiYMcbfMfUIP6daJl2EW5A+Wq0dkORj
 MPfkFx5DOR36l+x1G+Epp6KJPgcxQwAW4ziUnI6lqFeAnZtZd0eOsK8I
X-Gm-Gg: AR+sD11J+IGBiLzE9v1f5jtgB3nkWfB7rfFiXuQz7FTIPgf2JT33VcnDXnfQr19vgZl
 wsWqxa6PQ5qK+yyU+90TRno1j3TO1cHyGvUKAioqeXiAAEPfaQsRPWjQl605F3G6gMQgXVXiZdj
 ycDqbHx78ZB5VLrA1xOekDQFChrbS+hetKY4z24qbep/e0s+dnuFFYQDdr50ym4++kryEQWYW2v
 zGzDqm58Nu+RTkl29PTKAE0BiPe6nCxLOwlweLVY5BDMFXrVsVSfQRojFmHBW4sv/T1TRVazwGe
 Oywta+VP4uhVq1cVFLqpmOe7m5mQtAdQaUi8iZWmpnQGPSNGOatrchaOKfSpioq4UDZLTkyI+bH
 gHc1Va3yU7dxmOnRx19nzDeq+0zm5xPnZGqtsTUx3rCmQRFB2tFVo+4/QJ69UV+HqB7qfOaIHom
 lTLpjDEsJNiW3BtVZ7r94bzzeUAWeOgLNe9RabIUdCkVm9+CPJ3GzrKUp0yescRoSTAIyK5WGia
 nYloJiJol6ErBjykhv1SFQ8
X-Received: by 2002:a17:90b:4c8e:b0:396:65dd:4093 with SMTP id
 98e67ed59e1d1-3966d44daf1mr18399533a91.14.1787797673055; 
 Wed, 26 Aug 2026 19:27:53 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea80edsm671454a91.1.2026.08.26.19.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 19:27:52 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Thu, 27 Aug 2026 10:27:45 +0800
Message-ID: <20260827022745.4184511-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826153644.3726384-1-daeho43@gmail.com>
References: <20260826153644.3726384-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wzPqQ-0005h2-QL
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support resizable tail section and
 unify pinned allocation
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
