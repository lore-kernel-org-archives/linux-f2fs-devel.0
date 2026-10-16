Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9892DCC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4bt3MekPP4rHpAr5eMUPKnvvcFjdE1I4uN6caaC0GvI=; b=C7Sis5KrysfU2tdhZpHHj3U0Xm
	jZhn24AnRIPuqO7v2FGdea1nMC+Myv/a5S76BfJctkTcUBJ4H4Qk9XqyKReJZTK3XNhXC06PhxFxX
	n66ghfmbUHVeHg1lEdfc9NTA+LQkVivdjcgzeEHGoMZmZuhW3aDKpycPGLHe/Qm5DyXo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHlqK-0005u7-8Y;
	Fri, 16 Oct 2026 17:35:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@google.com>) id 1xHlqI-0005u1-SX
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 17:35:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cohS5KPUJ2GkeIniZLg5yBu1tNFxae8UdmbhqHbdHdc=; b=LocqVjmAIQDUjPGjox+9nKdfPu
 tSqh/CKww3ruiJcwdWhOM5FEkF/heqliU1gTs0yYDUUDdE0Nz7ghQzwEMSEUFd2enrTuVmIP9I/lu
 Blkypcil49H8JMilH8yxxkEMQiWCv+6pQzwYIS36GGaT3m1WImSplvtaCMWTrQcUSRKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cohS5KPUJ2GkeIniZLg5yBu1tNFxae8UdmbhqHbdHdc=; b=FGLodh5JJtgCWf0FE+BmdGuRiN
 qhdnvOus5aL7Vd6a8QqGsJbPAAWrYeFJEpH0rjt3Snxl1/CGaPZ1aEfWDR23ELmjm0KmRAdFFhiYh
 vDSQYsuHnbZcoc8NOwC+/gDiq8XPDfpUMOSm9+r57atkJYSD4r10k+a2ZTogHzUo0h94=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHlqD-0004KT-QO for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 17:35:40 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e977109392so457935ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792172132; x=1792776932;
 darn=lists.sourceforge.net; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cohS5KPUJ2GkeIniZLg5yBu1tNFxae8UdmbhqHbdHdc=;
 b=wDLQ2l99RTrssy1LrxipNDPMXd7u4OEs9lQCa2/iDo6rvGUZ0RIuXmBQKLY+BODvtI
 S7oXp0eTJmxF3rgT9r8VBCLlobr/XSBl9oKOjDWpOzq0Tq5grahrTW9Ulrl14tCcgIdd
 n+ZMSbylK96duy9MG454T/TfNOmnXUatLGsO+/qi+cq7l+tfIuHGeP0Hn3zdtdw66g7t
 DHznkul+198NY7pBa5V8WcTB1K+c/Es5mm1muRcJklG4G4MQlUa7tzqP2kRc5LBJjpxr
 uFYZRFFudgpVbc1VdR2y4B9fDB5Kxmy3XCTGNYawR8GR0isUwIsxgW/Vy3SO6NL+3dy3
 YmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792172132; x=1792776932;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cohS5KPUJ2GkeIniZLg5yBu1tNFxae8UdmbhqHbdHdc=;
 b=M9HV2Ta7KDV++89AK+XvBgHXySMZ7FNsZ3uE9swSfbG+cw9YEVM1akyEmg/WYrUynW
 WnJqmxCt/Bv5cAa/9VCVmQMZHazJ9EcvX6rLBtrnTtfEyVgh5LT8Ac/RIhmnWi2+/8F2
 4SzPF5xVMHWDtj+mJTIwlGLRSEwl+oJ22lcZZ5ygE1BYxhts9JZ/zn0Fn/7bHcV9AX4X
 0aCb9uzUXwq/r281fvxpFJQLP45q7hq+SrWUA94+AeTxrm5BTFgHFbJsOT1s7oRveohU
 1w2ATk96RlatZXYWWCCtwq4qQMSCirEPXZD+CUnhVCp3gm+5nfZ6e6uziAhOPuFFSBDv
 34xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQBh9HgZ5A7UO/BrbS3UYq5s9vV6M8ujNetEZgA096xEPKTTyCIrujDmtW87rTa6IIQKHay0zR7GnulKdlwPHc@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ7ygEAZ4l4eMCUDUmOP3PfkAyVi6srt/tZPK7QD2g3hGtycw1l
 zlfbEcuU8W/Smzvb6LiFI9364MxtW+d3J5Y2xpfcFeEBHeLRMP1fEJ3JIdwu/G4iDQ==
X-Gm-Gg: AYBFou3FyqrRMEriOzX7gH+FE9ci6EbnV9lQGuCgxdoywOMj0f+tAyrzKkxpznlXJ0N
 zO1x6jf6wAu73M/MmKDNg95yXDPhZtG7oerM4SnmkmlhFpbFYXF9V1mbuiLZvsC7xQu+Jqa/x5I
 fhsc+5o79z1NpnvgyVjmT/AVW/NXAeWG2MWww1UPe+GVD04t/WS6+DNx5tRYEAW6f6RcxOHSPBo
 dX7tUEcBTCsLFd8Vv89EMpt7H7qQEHY7mD5mjQTXIpElR8TC7UTF9BrjlAOUupOFMdKpjjezwoe
 dI+YTd3EgPCgANV3EfKkYOxniTdncGEPydpyNBL+MS53UZvrSHARdpqBobn+9hUGYXG59sZ3atu
 KwSxvl/EE8nsUAGNHDLBmpJVVX5NE60Y/drhqauyNBJBRL7JVI2NUa2g7s3KQB88dVIwQSw/LjW
 wyM4QPEOHPqZd0jcUV5KqVxqUZyLrQLMxS+VQdxz1k/GgNz3safYpmFqf4CAY9Uq5ieQOxfBoIk
 UouUJj/6h2npIKUc36hctCyxEczdjSLWf4CS0k8
X-Received: by 2002:a17:902:db09:b0:2e6:943:39de with SMTP id
 d9443c01a7336-2e9a6d26461mr5962425ad.30.1792172131142; 
 Fri, 16 Oct 2026 10:35:31 -0700 (PDT)
Received: from google.com (248.182.125.34.bc.googleusercontent.com.
 [34.125.182.248]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e8997edsm14024145ad.63.2026.10.16.10.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 10:35:30 -0700 (PDT)
Date: Fri, 16 Oct 2026 17:35:26 +0000
To: stable@vger.kernel.org
Message-ID: <20261016173526.GB122880@google.com>
References: <20261016172401.4002976-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261016172401.4002976-1-sashal@kernel.org>
X-Headers-End: 1xHlqD-0004KT-QO
Subject: Re: [f2fs-dev] Patch "f2fs: move release of block devices to after
 kill_block_super()" has been added to the 6.6-stable tree
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 stable-commits@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

[+Cc linux-f2fs-devel@lists.sourceforge.net]

On Fri, Oct 16, 2026 at 01:24:01PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: move release of block devices to after kill_block_super()
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-move-release-of-block-devices-to-after-kill_blo.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Not a clean cherry-pick, missing follow-on fix, and not Cc'ed to mailing
list.  Nack.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
