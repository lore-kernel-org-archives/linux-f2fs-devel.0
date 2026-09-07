Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3706C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JmSVAPGxPUoaDyrIBbqhI5Sw2k4DQHzRN2g/RCQAylI=; b=LbjMNJf69FVAKecftmBSJY44DG
	bXnmQx26yRa/Zo1Rs9ZODopgU1j+juWks05e1tFl9/JUcFkrM0d3+MCX4wXxn6OCuZATh/PlEUukg
	yUwQzXx8RrLNb1SLVOAxg6+ZjY57YF4w68O5plqT8JN06REF2h4R5DJ54naf8CKJAfSs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3TBE-00052M-Aq;
	Mon, 07 Sep 2026 06:50:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3TBA-00052D-1T
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7VFpsFqN5hv0mth4uo6pwkDrjHr3r43bvKIwfuyBXOU=; b=duQHe0+rgzDYUwPp5JStImOUaz
 Is7O1HgMEA0rdQ/pX4cbIa8N8Pdf5NQEZ2WkXs8qo27HLNKTOwW2G4vqDyeVuUEcr23Su7ZA8t0xR
 4pRSWWDOHaF8jcu8yU43wmjVUYeeyb9lOpxs2FCF8W3BuA9Zfzz+dbOlrOJDTQAA4KNA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7VFpsFqN5hv0mth4uo6pwkDrjHr3r43bvKIwfuyBXOU=; b=UW4BVhb/c4zSOY3PULpZqI/zIE
 mKg9hS46XxjTHyRwq4FpHw8pe1B2lRQA3xYcwJV9TZPMpdfAN7H1UD6+Unj0tiKg9p2nZqJz7u3V+
 FX4wILstLZ9TzuiBA9PfGJe+mkcGT25gPx9Os00p4h9XZzqkNblhxDuoBzd1K1M9JLtk=;
Received: from mail-pz2-f9.google.com ([74.125.228.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3TB9-0002of-E6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:50:08 +0000
Received: by mail-pz2-f9.google.com with SMTP id
 41be03b00d2f7-cc150711112so312864a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 23:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763802; x=1789368602; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7VFpsFqN5hv0mth4uo6pwkDrjHr3r43bvKIwfuyBXOU=;
 b=K86Nglai+ZlHlqoMXsa/YOey7/YM1Tmkpf6BSz3co2JKJgKueLhvaWbFFSvrqNOZhu
 AngUPA/XLnC2kx1suSeeWbEN4fvUoLsvZJQXYr2V+rbnflTgcuVa3gr589LUVUmqFCtq
 UdNI0avpz7jf7W2R+Jj6KXZYPwE5jQxgwXd/7tUYBM7MnHFCcpMsDiTJCPsYYaSq5Myn
 yRfmOoINuX2wJfWTJk+4XvzvuE1E8qcqGNfbTPHmx2QpXCRMLwEEN5/VIdIUodITaI5J
 TA+mqfzws3HpecL48FZei1dfn2Lqz7uHeEyJhT3c+vEsuoLsj4ec2EsO1DE2MI/Hsxs/
 4mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763802; x=1789368602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7VFpsFqN5hv0mth4uo6pwkDrjHr3r43bvKIwfuyBXOU=;
 b=Zt3fqd9c9p47Cug8Xc9TrRAVS1S9z2XFM51xsQZe/rylXzWsqjM9W9JakU3vXKjmLx
 AGVoyL65LYvVq7UVLGQMVBoWH5dncKK2wzp9hMY01pIOTGhwE9eTxMB6AUbkBu4plyct
 eQeBqwjGkaItzuyV3dY5RDDAEjW6QLU61odl8McbidmASMMnzjkkJgzzxGwNIJ6IZCGh
 vYuRG8FdKxNMQ2wUUWp75aQXwU6HTg7wa/xLpaF44cqjIzZ2SOmQbs36gCeQ6Es5GS+D
 uup0wm57h/iszeR661iLXbT/hrz4QwuTxx129UMUBk1EbvbVmGjQ5rCTaJ5o7R/W+FKr
 AzKA==
X-Forwarded-Encrypted: i=1;
 AKwUvByTydhNc7cst6+JD+3s+LXdncRw6e/mS2jpI8LB3ZNiaE8pYoyx48aUcK2M7eKjmDz6w8VBlVIoLS4Q4p80jPEL@lists.sourceforge.net
X-Gm-Message-State: AFuF++leVkqNOwQzH7Ia8WDCzRClLW+nZ6/cmF+fvnqV8fa9jvviajXa
 yrXMOoKx/6ApoTrChWnqAdCzAxlb2Myij8NtgEHtgjAttS5b4FjyTVkr
X-Gm-Gg: AYBFou2kIRfUPMFrrBzS+bPWqKvOZgFMZQ35NYmmZrJBTzDAONEDbKsRK3R0ASgKHi0
 Od8BqB+3MBCghvqxd6fDjmmB7c7BRf7FSgZKS0jga7tdYk96N9x9S8hf/B/NrsS7KKIbK5sq8rD
 CRvy1kfktvsIjxjEEYi/2yY5iRMPPbYtnmPHC/i6DF/SuhieH+l6UlnwZp86tJPnQ2gU8BMq9vY
 XC1HQ/97+sJi2B3tQOP3uCV9C4Rrm7UZdkjx155ky4TaFos+FTY6TZYA7Sb0iIMVjVvFinT3d4x
 b0etoAIfSPcabUIAkUrXVwc0U35wniN4APGTvCNDUjSD+fJRbONKY3OQz/jBPd6RbQaok03igqx
 hkHmaJ9l9uAIUCHZ15U216IjyV2uM2zLda02tqWVwKoP7clmj5RV31bDx84gBXFkTDSRITduUII
 IqGViUa4NHMqvyD4WPdKD9KyHNdfzfR7omTuodqFEvosDsvigJZaGvbWMZ5AjQyb/M/B49UmAet
 f4TptHU5VHW9/OGYUf8xJ2xUA==
X-Received: by 2002:a05:6a00:414e:b0:857:7384:b5f7 with SMTP id
 d2e1a72fcca58-861692846b6mr31875588b3a.19.1788763801572; 
 Sun, 06 Sep 2026 23:50:01 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152734e53sm3904452b3a.21.2026.09.06.23.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:49:59 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Daeho Jeong <daeho43@gmail.com>
Date: Mon,  7 Sep 2026 14:49:51 +0800
Message-ID: <20260907064951.2313595-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
References: <CACOAw_zD_a32UCJZ+F7zD61o0K8QAh7QKJVuag4fm98qWy7SRQ@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x3TB9-0002of-E6
Subject: Re: [f2fs-dev] [PATCH 01/14] f2fs: extend folio state for large
 folio write path
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 27 Aug 2026 13:51:06 -0700, Daeho Jeong wrote:
> I understand it is used to avoid failing in-flight I/O or writeback
> when allocating the subpage state. However, invoking __GFP_NOFAIL in
> memory reclaim/writeback paths risks OOM livelocks under extreme
> memory pressure.
>
> Ideally, we should ensure ffs is always pre-allocated during
> write_begin() and page_mkwrite() (where returning -ENOMEM to userspace
> is safe), so that the writeback path never has to allocate ffs on the
> fly with __GFP_NOFAIL.

Thanks for the review. I agree with your suggestion.
I'll remove GFP_NOFAIL in the next version.

By the way, I think GFP_NOIO is not necessary here either; GFP_NOFS
should be enough.

Hi Jaegeuk, what's your opinion?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
