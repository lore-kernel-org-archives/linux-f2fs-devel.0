From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/1] f2fs: fix validation of the block count in
 sanity_check_raw_super
Date: Mon, 24 Dec 2018 16:18:25 +0800
Message-ID: <0ad23150-72df-4bcc-851e-1da306e5a027@huawei.com>
References: <20181221192820.26222-2-martin.blumenstingl@googlemail.com>
 <201812221401.4m4zuU4G%fengguang.wu@intel.com>
 <CAFBinCA=-st_bM0Cz7mu-Hq6Asv5HAXPMwDZUjMj6GqMb8s=hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAFBinCA=-st_bM0Cz7mu-Hq6Asv5HAXPMwDZUjMj6GqMb8s=hw@mail.gmail.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/12/22 19:08, Martin Blumenstingl wrote:
> On Sat, Dec 22, 2018 at 8:00 AM kbuild test robot <lkp@intel.com> wrote:
>>
>> Hi Martin,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on f2fs/dev-test]
>> [also build test WARNING on v4.20-rc7 next-20181221]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Martin-Blumenstingl/f2fs-fix-sanity_check_raw_super-on-big-endian-machines/20181222-142616
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
>> config: i386-randconfig-x006-201850 (attached as .config)
>> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
>> reproduce:
>>         # save the attached .config to linux build tree
>>         make ARCH=i386
>>
>> All warnings (new ones prefixed by >>):
>>
>>    fs/f2fs/super.c: In function 'sanity_check_raw_super':
>>>> fs/f2fs/super.c:2498:46: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'long long unsigned int' [-Wformat=]
>>        "Wrong segment_count / block_count (%u > %u)",
>>                                                 ~^
>>                                                 %llu
> I sent a v2 with this fixed and Chao Yu's reviewed by included

Sorry, I didn't catch previous print issue on v1, anyway, I'm okay with v2. :)

Thanks,

> 
> .
> 
