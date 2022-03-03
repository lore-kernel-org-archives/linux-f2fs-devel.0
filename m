Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6020C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Mar 2022 08:30:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nPgrE-00050a-6J; Thu, 03 Mar 2022 08:30:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <xiam0nd.tong@gmail.com>)
 id 1nPgrC-000508-Br; Thu, 03 Mar 2022 08:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uLpTC29O7sSEzWIyhD1PQNyRAs1/upRhzEEBO0P7TrY=; b=Wn8qGt3dPCzjU6a5utmHQI+g2o
 4murKg8RXrF7/cKt1a8XdKdbwywtKYrsx2X7n8tGtQwheoEEQlLKeGwRsa+UInDbFZGee2hEQe/b8
 oMkCEeTya2DgPaBXpt3DLJS3CIEkWl+GiG0GGf1E2pSLNKyXs/3pGcA4+WFlsuj7wwzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uLpTC29O7sSEzWIyhD1PQNyRAs1/upRhzEEBO0P7TrY=; b=G14EfAvtCRQ2V/U3Ff/QA2cHef
 Kc4uKZxJppPHmDsEjnsCMbdIaghmp7biWKuxJaPG1X/ZA/XZt0a/pdbe9Poq9u7WutrsrE2Ddi06f
 bqpt10CaMNHVWu7cl1jK3g6EJVW1D2K3dzVHd9MSaBuFoMQeh37OdgLXrEYro3rpR5qw=;
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nPgrA-003Orj-D1; Thu, 03 Mar 2022 08:30:40 +0000
Received: by mail-pg1-f196.google.com with SMTP id 12so3939456pgd.0;
 Thu, 03 Mar 2022 00:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uLpTC29O7sSEzWIyhD1PQNyRAs1/upRhzEEBO0P7TrY=;
 b=R05ZV01Yp+GvJafCjJwp2DdNQL1X7N4+v2qDpWCUjxekJqjhV8nKttt+lgDdDv8VHZ
 pTpad4a62LLA8SjB/yHHEpNTxY0U28zfBa611uCN9ihzVETreTphlyPy+ETyTE4AgOSy
 RSp6pqcLA1mQfW+JjTEEtr3nMT+EN3gAPPB7pPpCIhAgeloFO+Vkph8Zctn11Qajj/U0
 QUVjSv6dTXzOO7akWefQCdrhFJznQKo01Wl+2crhxprXX9zSh/gHLWP/Xe3lMKAcW1nu
 BI3FrzUOW0QskfQ+hVH91vnr00ExY+gCD8VtMWG6RhFXS05x/6dGZMaR1NPNguf29zlo
 qAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uLpTC29O7sSEzWIyhD1PQNyRAs1/upRhzEEBO0P7TrY=;
 b=jVpqNQjQwvN6OziLsbhj2HMoHkOZZV/utyB3JzE4E9DsWYUoe2xEWgouC+mm88QpMQ
 deL3cUpS6QUxSBdflm4IDQp6uVd1ry2wHkWlCEafoxB3lvytOH8nulDwLorEUzQi1okO
 gT+5ctpIzh5mVe6yUsrqxr45ABdIqeBj+WX8bmVzkDqUEHEZdZUjy86oXsu0yktmwmY1
 XkT3qV2gVbC8lOzc+epTHW/CCpLkONPV1EI2VJDWoZG6sXUlAPUR938FmhSun98QnWYu
 OD7V4Pou7V8cDvwXQM3gPTNP7MDia0F6KA31DSvCnB9iz3Ki6fjwfwoQ+7BhmEntRaZG
 l9BA==
X-Gm-Message-State: AOAM5306U0SzSy7ZcEy85tAFU34y7bFf4jDhC5VlTbf9jEJOaCFVVeyD
 MwsYbHyxbV065/EG2uLGT8k=
X-Google-Smtp-Source: ABdhPJxl3tqNmXwEb6Rf4RyrJiQAiYb1f64m7AmzgvvLqhkGp3dQvJbj8a24YWybBg5gGNAc3KtcpA==
X-Received: by 2002:a63:8bca:0:b0:370:2717:3756 with SMTP id
 j193-20020a638bca000000b0037027173756mr29011952pge.604.1646296234811; 
 Thu, 03 Mar 2022 00:30:34 -0800 (PST)
Received: from ubuntu.huawei.com ([119.3.119.19])
 by smtp.googlemail.com with ESMTPSA id
 d5-20020a17090acd0500b001b9c05b075dsm7342532pju.44.2022.03.03.00.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:30:34 -0800 (PST)
From: Xiaomeng Tong <xiam0nd.tong@gmail.com>
To: jakobkoschel@gmail.com
Date: Thu,  3 Mar 2022 16:30:07 +0800
Message-Id: <20220303083007.11640-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <A568BD90-FE81-4740-B1D3-C795EB636A5A@gmail.com>
References: <A568BD90-FE81-4740-B1D3-C795EB636A5A@gmail.com>
X-Headers-End: 1nPgrA-003Orj-D1
Subject: Re: [f2fs-dev] [PATCH 2/6] treewide: remove using list iterator
 after loop body as a ptr
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
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org, gustavo@embeddedor.com,
 linux-iio@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux@rasmusvillemoes.dk, dri-devel@lists.freedesktop.org, c.giuffrida@vu.nl,
 amd-gfx@lists.freedesktop.org, torvalds@linux-foundation.org,
 samba-technical@lists.samba.org, linux1394-devel@lists.sourceforge.net,
 drbd-dev@lists.linbit.com, linux-arch@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-staging@lists.linux.dev, h.j.bos@vu.nl, jgg@ziepe.ca,
 intel-wired-lan@lists.osuosl.org, nouveau@lists.freedesktop.org,
 bcm-kernel-feedback-list@broadcom.com, dan.carpenter@oracle.com,
 linux-media@vger.kernel.org, keescook@chromium.org, arnd@arndb.de,
 linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 bjohannesmeyer@gmail.com, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, christophe.jaillet@wanadoo.fr,
 v9fs-developer@lists.sourceforge.net, linux-tegra@vger.kernel.org,
 tglx@linutronix.de, andriy.shevchenko@linux.intel.com,
 linux-arm-kernel@lists.infradead.org, linux-sgx@vger.kernel.org,
 nathan@kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, xiam0nd.tong@gmail.com,
 David.Laight@ACULAB.COM, tipc-discussion@lists.sourceforge.net,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mediatek@lists.infradead.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, christian.koenig@amd.com, rppt@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> I think this would make sense, it would mean you only assign the containing
> element on valid elements.
>
> I was thinking something along the lines of:
>
> #define list_for_each_entry(pos, head, member)					\
>	for (struct list_head *list = head->next, typeof(pos) pos;	\
>	     list == head ? 0 : (( pos = list_entry(pos, list, member), 1));	\
>	     list = list->next)
>
> Although the initialization block of the for loop is not valid C, I'm
> not sure there is any way to declare two variables of a different type
> in the initialization part of the loop.

It can be done using a *nested loop*, like this:

#define list_for_each_entry(pos, head, member)					\
	for (struct list_head *list = head->next, cond = (struct list_head *)-1; cond == (struct list_head *)-1; cond = NULL) \
	  for (typeof(pos) pos;	\
	     list == head ? 0 : (( pos = list_entry(pos, list, member), 1));	\
	     list = list->next)

>
> I believe all this does is get rid of the &pos->member == (head) check
> to terminate the list.

Indeed, although the original way is harmless.

> It alone will not fix any of the other issues that using the iterator
> variable after the loop currently has.

Yes, but I stick with the list_for_each_entry_inside(pos, type, head, member)
way to make the iterator invisiable outside the loop (before and after the loop).
It is maintainable longer-term than "type(pos) pos" one and perfect.
see my explain:
https://lore.kernel.org/lkml/20220302093106.8402-1-xiam0nd.tong@gmail.com/
and list_for_each_entry_inside(pos, type, head, member) patch here:
https://lore.kernel.org/lkml/20220301075839.4156-3-xiam0nd.tong@gmail.com/

--
Xiaomeng Tong


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
