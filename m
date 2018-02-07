From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] mkfs.f2fs: set .so to cold files
Date: Wed, 7 Feb 2018 19:42:20 +0800
Message-ID: <a68c7c47-136d-9f8b-09f5-f5a338d996be@kernel.org>
References: <20171103031315.10959-1-jaegeuk@kernel.org>
 <CAD14+f2K_Z7rYBH0XtWLP1yyemkVZJGucRJj7t987aygSro-ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ejO7g-0005bg-A7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 11:42:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejO7e-0007h0-Oi
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 11:42:43 +0000
In-Reply-To: <CAD14+f2K_Z7rYBH0XtWLP1yyemkVZJGucRJj7t987aygSro-ZA@mail.gmail.com>
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
To: Ju Hyung Park <qkrwngud825@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/2/6 1:43, Ju Hyung Park wrote:
> I'm not entirely familiar with how cold and hot files are treated in f2fs,
> but I'm going to assume it has to do something with GC and
> less-prioritizing for random R/W operations.
> 
> If my assumption is correct, I see some things problematic here.
> 
> Android still does a lot of random reads inside .apk files.
> While the Java bytecodes are compiled and stored separately in
> /data/app/*/base.odex and base.vdex,
> resources(graphics, assets, etc) are still directly accessed from the
> .apk files(which btw, I really want Google to change to access via
> Linux filesystem directly).
> 
> And .so extensions are not Android specific. Those are shared
> libraries and desktop distros also use them.
> A simple `find /usr /lib* -name '*.so' | wc -l` run on my Ubuntu setup
> returns 7382 files. While most Android's /system partition is
> formatted as ext4, I'm not sure if you still want to do that for the
> rest of the user app's libraries(stored in /data/app/*/lib).
> 
> Are these really intended?

Yup.

> I'd appreciate if someone explain how cold and hot files are treated
> differently.

f2fs makes all cold files going into cold type data segments, normally,
predefined cold file won't change in its life time anymore, so we can
expect that there will be less GC triggered on those cold type segment
than segment contains both hot and cold data.

> 
> And also, I don't understand why one would want this hardcoded to the
> block device at the time of mkfs.
> Wouldn't it make much more sense to ship new lists on each Linux merge
> windows and allow users to customize on runtime via sysfs?

Agreed. If new cold type file was discovered, we should not let user configure
the extension list by mkfs which may make all data lost.

Thanks,

> 
> On Fri, Nov 3, 2017 at 12:13 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> This patch adds .so in cold file extention list.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>  mkfs/f2fs_format.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
>> index 2103f9d..2ba8dd3 100644
>> --- a/mkfs/f2fs_format.c
>> +++ b/mkfs/f2fs_format.c
>> @@ -62,6 +62,7 @@ const char *media_ext_lists[] = {
>>         "jpeg",
>>         "video",
>>         "apk",  /* for android system */
>> +       "so",   /* for android system */
>>         NULL
>>  };
>>
>> --
>> 2.14.0.rc1.383.gd1ce394fe2-goog
>>
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
