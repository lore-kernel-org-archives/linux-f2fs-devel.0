From: Chao Yu <yuchao0@huawei.com>
Subject: Re: f2fs: prevent mount with "extended node bitmap" on
 older kernels
Date: Thu, 13 Dec 2018 19:12:20 +0800
Message-ID: <a1035303-6593-92de-ce3e-7f090fa4890d@huawei.com>
References: <CAD14+f18VYrabAOvZocx3U3V9j0pKFHBBK+UzvygO=m5Aa_EKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gXOv7-0006mr-It
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Dec 2018 11:12:45 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gXOuu-00FEKL-5D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Dec 2018 11:12:45 +0000
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 72686DC7D2CAC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 13 Dec 2018 19:12:23 +0800 (CST)
In-Reply-To: <CAD14+f18VYrabAOvZocx3U3V9j0pKFHBBK+UzvygO=m5Aa_EKQ@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ju Hyung Park <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Ju Hyung,

Sorry for the delay.

On 2018/12/9 20:51, Ju Hyung Park wrote:
> Hi,
> 
> I was testing around the "extended node bitmap" feature within f2fs
> and found an issue with fsck.f2fs resulting in false-positives
> and causing further corruptions when data is written by older kernels.
> 
> I can reliably reproduce this issue with a simple image creation
> and fsck with Linux 4.15.
> 
> # fallocate -l 2G f2fs.img
> # mkfs.f2fs -i f2fs.img
> # mount f2fs.img /mnt
> # rsync -a /var/ /mnt/
> # umount /mnt
> # fsck.f2fs -f --dry-run f2fs.img
> 
> This results in the following behavior with the latest f2fs-tools
> v1.12.0 and Linux 4.15:
> https://pastebin.com/MTKpa2AC
> (A side note, 2nd run of fsck still shows some errors being fixed.)
> 
> I cannot reproduce this issue with Linux 4.19.
> Is this new feature supposed to be only used with recent kernels?

That's correct, the feature was enabled in Linux 4.17 kernel, so the image
should be fit for 4.17+ kernel.

> 
> If so, mount should be prevented on older kernels, at least writes.
> (I'm noticing reads are fine with older kernels.)

I guess it will be a little hard for old kernel to be aware of such image
with new feature, since different kernel support different features, we
have to:
- adjust all old kernels to recognize the features they don't support.
- once new feature is introduced in mkfs, we need to adjust all old kernels..

So the easy way I can imagine is that, during mkfs or in documentation, we
can remind user the lowest version of kernel for the feature user want to
use, then user can select kernel with correct version to match the image.

Thanks,

> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 
