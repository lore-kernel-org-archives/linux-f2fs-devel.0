From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 2/2] mkfs.f2fs: make the default extensions
 list much more sensical
Date: Sat, 20 Apr 2019 10:14:54 +0800
Message-ID: <ce48b007-ffb6-defc-4ff3-986972f6cee2@huawei.com>
References: <20190416064355.29712-1-qkrwngud825@gmail.com>
 <20190416064355.29712-2-qkrwngud825@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hHfWy-0001pR-Uc
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 02:15:04 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hHfWw-000wJ1-Uy
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Apr 2019 02:15:04 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 60C262F8AE80A24AEEE3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 20 Apr 2019 10:14:54 +0800 (CST)
In-Reply-To: <20190416064355.29712-2-qkrwngud825@gmail.com>
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
To: Park Ju Hyung <qkrwngud825@gmail.com>, linux-f2fs-devel@lists.sourceforge.net



On 2019/4/16 14:43, Park Ju Hyung wrote:
> Following extensions are removed:
>  - divx: deprecated video format and it's usually wrapped with avi
>  - asf: deprecated streaming format
>  - asx: redirecting file to asf(small)
>  - wmx: redirecting file to wma/wmv(small)
>  - rm: deprecated media container
>  - video: unused
>  - wv: unpopular audio format from 1998
> 
> The extensions list is limited to 64 and those don't deserve to be
> on this space-precious list.
> 
> Common prefixes are introduced and are checked with
> https://en.wikipedia.org/wiki/List_of_filename_extensions
> to avoid treating possible hot files as cold:
>  - mp: covers mp3, mp4, mpeg, mpg
>  - wm: covers wma, wmb, wmv
>  - og: covers oga, ogg, ogm, ogv
>  - jp: covers jpg, jpeg, jp2
> 
> Following extensions are added:
>  - webm: extremely popular free media container format from Google
>          VP8/VP9/AV1 and Vorbis/Opus is often wrapped with this container
>  - wav: uncompressed audio format, commonly used with voice recorders
>  - svg: vector image format commonly used in web
>  - webp: free lossy image format commonly used in web
>  - jar: Java archive file
>  - deb: Debian software package
>  - iso: disk image file
>  - gz: gzip compressed file, unable to randomly update
>  - xz: xz compressed file, unable to randomly update
>  - zst: zstd compressed file, unable to randomly update
>  - pdf: PDF document
>  - pyc: Python bytecode automatically generated when
>         executing python to run .py files
>  - ttc, ttf: font files
>  - cnt: image alias files commonly used in Android apps
>  - exo: EXO player's cache files, commonly used in Android's YouTube app
>  - odex, vdex: Android RunTime files found in /data/app/*/oat
> 
> Total entries on the list changed from 34 to 36.
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
