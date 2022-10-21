Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB633C43219
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Oct 2022 08:36:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olnVx-00006S-Ob;
	Fri, 21 Oct 2022 08:36:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gregkh@linuxfoundation.org>) id 1olnVw-00006M-O0
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Oct 2022 08:36:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t1YS74Nvk7oCxM1pKvXyLB5PZcp3CtEHrUYkNo4yhow=; b=Lo6vL+Rz7OuEcODlXPYekjTPX1
 bTF+MlG9OVqwYs1GcnVG0sxYmHDm1DN8nHZ5PiXLuHkFJflJWWZ8ZM5DNboTLhHEz8BIkHJsvE70M
 bjwvcPA10ZY8NwmxlUkJbxDNKaFU2rdqNUCPg2GcixGWap2Udv8oMIoWQ8sOOmUR5bcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t1YS74Nvk7oCxM1pKvXyLB5PZcp3CtEHrUYkNo4yhow=; b=NRZBif5zh2546zIo6PRrdKCxqJ
 v+TAna4zswFemZFWAmoq700ieYvUSpFwrdX4x1DLlBSpJoYGcB0jDh5XUYXvRmoXO4poKMp6BgxUb
 SmO6QvkQ/BrthNnvW5cmoMk21SV6UGIZ7qHSRZWMMDC2H5uctiwU7BxQLOlqSDwS5PIc=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olnVs-00C3vF-JU for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Oct 2022 08:36:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 95B30B82B63;
 Fri, 21 Oct 2022 08:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57E2C433D6;
 Fri, 21 Oct 2022 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1666341367;
 bh=VYkxOdyqZTRP94uFOMrKlhrYPkv6+oVeaJOCigiokeE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0LHArjuO/emmogeedg4sidpH81EIC1oFajIQk20rr9Km/Y0ewObOQB0i43jXid6V8
 MEWVl4mxIE2auEWLdOFh5S0zN7a5cdswL8kZv1F5sHrcBCX+9z8wc+kpjX8Czr8S07
 DVGuTf4yxBxOxcpimxvN26SCCFuV+ZffgRv7I1WQ=
Date: Fri, 21 Oct 2022 10:36:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <Y1JZ9IUPL6jZIQ8E@kroah.com>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com>
 <Y1IwLOUGayjT9p6d@kroah.com>
 <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0591e66f-731a-5f81-fc9d-3a6d80516c65@huawei.com>
X-Headers-End: 1olnVs-00C3vF-JU
Subject: Re: [f2fs-dev] [PATCH 00/11] fix memory leak while kset_register()
 fails
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
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com,
 joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, richard@nod.at,
 mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org,
 Luben Tuikov <luben.tuikov@amd.com>, hsiangkao@linux.alibaba.com,
 somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 alexander.deucher@amd.com, akpm@linux-foundation.org,
 linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Oct 21, 2022 at 04:24:23PM +0800, Yang Yingliang wrote:
> =

> On 2022/10/21 13:37, Greg KH wrote:
> > On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
> > > On 2022-10-20 22:20, Yang Yingliang wrote:
> > > > The previous discussion link:
> > > > https://lore.kernel.org/lkml/0db486eb-6927-927e-3629-958f8f211194@h=
uawei.com/T/
> > > The very first discussion on this was here:
> > > =

> > > https://www.spinics.net/lists/dri-devel/msg368077.html
> > > =

> > > Please use this link, and not the that one up there you which quoted =
above,
> > > and whose commit description is taken verbatim from the this link.
> > > =

> > > > kset_register() is currently used in some places without calling
> > > > kset_put() in error path, because the callers think it should be
> > > > kset internal thing to do, but the driver core can not know what
> > > > caller doing with that memory at times. The memory could be freed
> > > > both in kset_put() and error path of caller, if it is called in
> > > > kset_register().
> > > As I explained in the link above, the reason there's
> > > a memory leak is that one cannot call kset_register() without
> > > the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
> > > in this case, i.e. kset_register() fails with -EINVAL.
> > > =

> > > Thus, the most common usage is something like this:
> > > =

> > > 	kobj_set_name(&kset->kobj, format, ...);
> > > 	kset->kobj.kset =3D parent_kset;
> > > 	kset->kobj.ktype =3D ktype;
> > > 	res =3D kset_register(kset);
> > > =

> > > So, what is being leaked, is the memory allocated in kobj_set_name(),
> > > by the common idiom shown above. This needs to be mentioned in
> > > the documentation, at least, in case, in the future this is absolved
> > > in kset_register() redesign, etc.
> > Based on this, can kset_register() just clean up from itself when an
> > error happens?  Ideally that would be the case, as the odds of a kset
> > being embedded in a larger structure is probably slim, but we would have
> > to search the tree to make sure.
> I have search the whole tree, the kset used in bus_register() - patch #3,
> kset_create_and_add() - patch #4
> __class_register() - patch #5,=A0 fw_cfg_build_symlink() - patch #6 and
> amdgpu_discovery.c - patch #10
> is embedded in a larger structure. In these cases, we can not call
> kset_put() in error path in kset_register()

Yes you can as the kobject in the kset should NOT be controling the
lifespan of those larger objects.

If it is, please point out the call chain here as I don't think that
should be possible.

Note all of this is a mess because the kobject name stuff was added much
later, after the driver model had been created and running for a while.
We missed this error path when adding the dynamic kobject name logic,
thank for looking into this.

If you could test the patch posted with your error injection systems,
that could make this all much simpler to solve.

thanks,

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
