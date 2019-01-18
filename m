From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: f2fs issue on linux-5.0.0-rc2
Date: Fri, 18 Jan 2019 22:47:19 +0800
Message-ID: <CAAJw_Zt4JeUNqoqbWUmkraVDtf4w1EekRuPOCDikFgXXKU192A@mail.gmail.com>
References: <CAAJw_Zuf=-BUYQDpbB2Yk2z9hG7ikzNoyPB4DScJp4n7JN+sCw@mail.gmail.com>
 <4ffd83a1-8599-5f39-1114-4f878dbfcc4e@huawei.com>
 <CAAJw_ZtdyAevOER-aQn7JoTCYimL2KjKPNvG0HkfqX7g7suqMg@mail.gmail.com>
 <CAAJw_Zsp2HuwuchdkjTmmh2=e+PbEeG4b7DQG47LO0mwVK8ucA@mail.gmail.com>
 <1ecee05b-4e6e-f916-514b-94d885670f39@codeaurora.org>
 <85fefeea-1ef3-fb32-6b54-923c1b79b174@huawei.com>
 <CAAJw_Zs9LU7L+TfvRkpyNQ8Teh+VtQ8sokiuEWtBx_t=6EgBNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jeff.chua.linux@gmail.com>) id 1gkVQp-00073R-JG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Jan 2019 14:47:39 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gkVQo-00FGQF-1b
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Jan 2019 14:47:39 +0000
Received: by mail-wm1-f51.google.com with SMTP id f188so4713202wmf.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Jan 2019 06:47:37 -0800 (PST)
In-Reply-To: <CAAJw_Zs9LU7L+TfvRkpyNQ8Teh+VtQ8sokiuEWtBx_t=6EgBNA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Fri, Jan 18, 2019 at 10:21 PM Jeff Chua <jeff.chua.linux@gmail.com> wrote:
>
> On Fri, Jan 18, 2019 at 4:56 PM Chao Yu <yuchao0@huawei.com> wrote:
> >
> > On 2019/1/18 10:10, Ritesh Harjani wrote:
> > >
> > > On 1/17/2019 5:04 PM, Jeff Chua wrote:
> > >> On Thu, Jan 17, 2019 at 7:33 PM Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> > >>> On Thu, Jan 17, 2019 at 10:00 AM Chao Yu <yuchao0@huawei.com> wrote:
> > >>>> On 2019/1/16 20:57, Jeff Chua wrote:
> > >>>>> This is on rpi3b+ running latest linux git pull, and root filesystem
> > >>>>> is "read-only" ...
> > >>>> Did you hit this issue after you upgrade kernel from lower one to 5.0?
> > >>> No, it was ok. Works perfectly.
> > >>>
> > >>>> Why there are dirty data/node in readonly filesystem?
> > >>> No idea. It's fresh boot up.
> > >>>
> > >>>> Could you try below commands to make sure where it actually crash?
> > >>>> gdb f2fs.ko
> > >>>> l *(f2fs_balance_fs_bg+0x26c/0x2a8)
> > >>>> l *(f2fs_build_free_nids+0x394/0x510)
> > >>> Ok, that will take a while. I'll need to revert back to pre-5.0 and
> > >>> install gdb first and try to debug it.
> > >> Oh, btw, there's no "f2fs.ko" ... f2fs is compiled as built-in instead
> > >> of a module.
> > >
> > > you could also try using below script in kernel dir.
> > >
> > > ./scripts/faddr2line <vmlinux path> f2fs_balance_fs_bg+0x26c
> > >
> > > ./scripts/faddr2line <vmlinux path> f2fs_build_free_nids+0x394
> >
> > That's correct, thanks for your help. ;)
>
>
> PC is at f2fs_balance_fs_bg+0x26c/0x2a8
> LR is at f2fs_build_free_nids+0x394/0x510
> ./scripts/faddr2line vmlinux f2fs_balance_fs_bg+0x26c/0x2a8
>         f2fs_balance_fs_bg+0x26c/0x2a8:
>         f2fs_balance_fs_bg at ??:?
> ./scripts/faddr2line vmlinux f2fs_build_free_nids+0x394/0x510
>         f2fs_build_free_nids+0x394/0x510:
>         f2fs_build_free_nids at ??:?
>
> Looks like I'm missing something. My rpi3 kernel is loaded zImage ..
> # scripts/mkknlimg harch/arm/boot/zImage kernel7.img
>
> Or need to recompile kernel with debug symbols?

recompiled with
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y

faddr2line still not showing any thing ...




-- 
My best.,
Jeff
